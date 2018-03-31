<?php 
    include "./config.php";
    include "./pdo-plus/src/PDO.class.php";
    $db=DB::getInstance($database);
    $type=isset($_POST['type'])?$_POST['type']:"";
    switch ($type) {
        case 'login':
            $userid=intval($_POST['userid']);
            $password=htmlspecialchars(md5($_POST['password']));
            // $sql="SELECT id,username,photo,qianming,online from user where id=$userid and password='$password'";
            // $arr=$db->query($sql);
            $arr=$db->query("SELECT id,username,photo,qianming,online from user where id=? and password=?",[$userid,$password]);
            if($arr && count($arr)==1){
                if($arr[0]['online']!=1){
                    $sql1="UPDATE user SET online=1 where id=$userid";
                    $num=$db->query("UPDATE user SET online=1 where id=?",[$userid]);
                    // $num=$db->update("user",['online'=>1],"id=$userid");
                }else{
                    $num=1;
                }
                if($num==1){
                    if(isset($_POST['memory']) && $_POST['memory']){
                        setcookie("UserID",$userid,time()+3600*24*365);
                        setcookie("UserName",$arr[0]["username"],time()+3600*24*365);
                        setcookie("Photo",$arr[0]["photo"],time()+3600*24*365);
                    }else{
                        setcookie("UserID",$userid);
                        setcookie("UserName",$arr[0]["username"]);
                        setcookie("Photo",$arr[0]["photo"]);
                    }
                }
                echo json_encode(["state"=>$num,"data"=>$arr[0]]);   
            }else{
                echo json_encode(["state"=>0]);
            }
            break;
        case 'getGroupsFriends':
            $userid=intval($_POST['userid']);
            $sql="SELECT groups from friendgroups where userid=?";
            $arr=$db->query($sql,[$userid]);
            if(count($arr)){
                $arr1=explode(",", $arr[0]["groups"]);
            }else{
                $arr1=[];
            }
            $sql2="SELECT friendid,groupid,photo,online,qianming as userinfo,username,user.id as userid from friends left join user on friends.friendid=user.id where userid=? order by online desc";
            $arr2=$db->query($sql2,[$userid]);
            echo json_encode(["state"=>1,"data"=>["groups"=>$arr1,"friends"=>$arr2]]);
            break;
        case "getMoreMsgs":
            $page=intval($_POST['page'])??1;
            $size=intval($_POST['size'])??20;
            $RLtime=intval($_POST['RLtime'])??0;
            $withUid=intval($_POST['withUid'])??0;
            if($withUid){
                if($RLtime){
                    $msgs=$db->query("SELECT fromid,toid,message,readed,create_time from talk where create_time<? and ((fromid=? and toid=?) or (fromid=? and toid=?))",[$RLtime,$_COOKIE['UserID'],$withUid,$withUid,$_COOKIE['UserID']]);
                }else{
                    $msgs=$db->query("SELECT fromid,toid,message,readed,create_time from talk where (fromid=? and toid=?) or (fromid=? and toid=?)",[$_COOKIE['UserID'],$withUid,$withUid,$_COOKIE['UserID']]);
                }
                echo json_encode(['state'=>1,"data"=>$msgs]);
            }else{
                echo json_encode(['state'=>0]);
            }
            break;
        case "getLeftMsgs":
            $page=intval($_POST['page'])??1;
            $size=intval($_POST['size'])??20;
            $withUid=intval($_POST['withUid'])??0;
            if($withUid){
                $msgs=$db->query("SELECT fromid,toid,message,readed,create_time from talk where readed=0 and ((fromid=? and toid=?) or (fromid=? and toid=?))",[$_COOKIE['UserID'],$withUid,$withUid,$_COOKIE['UserID']]);
                echo json_encode(['state'=>1,"data"=>$msgs]);
            }else{
                echo json_encode(['state'=>0]);
            }
            break;
        default:
            # code...
            break;
    }
    // $db->destruct();