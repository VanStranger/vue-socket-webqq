<?php
use Workerman\Worker;
use Workerman\Lib\Timer;
require_once "./config.php";
require_once './Workerman/Autoloader.php';
require_once "./pdo-plus/src/PDO.class.php";
// 心跳间隔25秒
define('HEARTBEAT_TIME', 25);
$worker = new Worker('websocket://0.0.0.0:1234');
// 这里进程数必须设置为1
$worker->count = 1;
// worker进程启动后建立一个内部通讯端口
$worker->onWorkerStart = function($worker)
{
    // 开启一个内部端口，方便内部系统推送数据，Text协议格式 文本+换行符
    global $db;
    global $database;
    $db=DB::getinstance($database);
    $inner_text_worker = new Worker('Text://0.0.0.0:5678');
    $inner_text_worker->onMessage = function($connection, $buffer)
    {
        global $worker;
        // $data数组格式，里面有uid，表示向那个uid的页面推送数据
        $data = json_decode($buffer, true);
        $uid = $data['uid'];
        // 通过workerman，向uid的页面推送数据
        $ret = sendMessageToUid($uid, $buffer);
        // 返回推送结果
        $connection->send($ret ? 'ok' : 'fail');
    };
    $inner_text_worker->listen();
    Timer::add(5, function()use($worker){
            broadcast(json_encode(array("type"=>"ping")));
            $time_now = time();
            foreach($worker->connections as $connection) {
                // 有可能该connection还没收到过消息，则lastMessageTime设置为当前时间
                if (empty($connection->lastMessageTime)) {
                    $connection->lastMessageTime = $time_now;
                    continue;
                }
                // 上次通讯时间间隔大于心跳间隔，则认为客户端已经下线，关闭连接
                if ($time_now - $connection->lastMessageTime > HEARTBEAT_TIME) {
                    // $connection->close();
                }
            }
        });
};
// 新增加一个属性，用来保存uid到connection的映射
$worker->uidConnections = array();
// 当有客户端发来消息时执行的回调函数
$worker->onMessage = function($connection, $data)use($worker)
{
    // 判断当前客户端是否已经验证,既是否设置了uid
    global $db;
    $connection->lastMessageTime = time();
    $json=json_decode($data,true);
    echo $data."\n";
    switch ($json['type']) {
        case 'login':
            if($json['uid']){
                echo $json['uid'];
            	$connection->uid = $json['uid'];
		       /* 保存uid到connection的映射，这样可以方便的通过uid查找connection，
		        * 实现针对特定uid推送数据
		        */
               if(isset($worker->uidConnections[$connection->uid])){
                sendMessageToUid($json['uid'],json_encode(array("type"=>"pushOff")));
                unset($worker->uidConnections[$json['uid']]);
               }
		       $worker->uidConnections[$connection->uid] = $connection;
            }
            break;
        case 'sendtoUid':
            if($json['toid'] && $json['message'] && $json['fromid']){
                $num=$db->query("INSERT INTO talk (fromid,toid,message,create_time,readed) values(?,?,?,?,?)",[$json['fromid'],$json['toid'],$json['message'],($json['create_time']??time()),0]);
                if($num==1){
                    $msgid=$db->lastInsertId();
                }else{
                    $msgid=0;
                }
                sendMessageToUid($json['toid'],json_encode(["type"=>"newmessage","fromid"=>$json['fromid'],"message"=>$json['message'],"msgid"=>$msgid]));
            }
            break;
        case "readmessage":
            if($json['fromid'] && $json['toid'] && $json['msgids']){
                sendMessageToUid($json['fromid'],json_encode(["type"=>"readedmessage","toid"=>$json['toid'],"msgids"=>json_encode($json['msgids'])]));
                for($i=0,$len=count($json['msgids']);$i<$len;$i++){
                    $message=$db->query("SELECT toid from talk where id=?",[$json['msgids'][$i]]);
                    if($message && $message[0]['toid']==$json['toid']){
                        $db->query("UPDATE talk set readed=1 where id=?",[$json['msgids'][$i]]);
                    }
                }
            }
            break;
        default:
            
            break;
    }
    
};

// 当有客户端连接断开时
$worker->onClose = function($connection)use($worker)
{
    global $worker;
    if(isset($connection->uid))
    {
        // 连接断开时删除映射
        echo $connection->uid."断开连接\n";
        unset($worker->uidConnections[$connection->uid]);
    }
};

// 向所有验证的用户推送数据
function broadcast($message)
{
   global $worker;
   foreach($worker->uidConnections as $connection)
   {
        $connection->send($message);
   }
}

// 针对uid推送数据
function sendMessageToUid($uid, $message)
{
    global $worker;
    if(isset($worker->uidConnections[$uid]))
    {
        $connection = $worker->uidConnections[$uid];
        $connection->send($message);
        return true;
    }
    return false;
}

// 运行所有的worker（其实当前只定义了一个）
Worker::runAll();