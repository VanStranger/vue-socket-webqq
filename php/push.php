<?php
$client = stream_socket_client('tcp://127.0.0.1:5678', $errno, $errmsg, 1);
// 推送的数据，包含uid字段，表示是给这个uid推送
// for($i=0;$i<100;$i++){

// 	$data = array('uid'=>'1', 'percent'=>$i.'%');
// 	// 发送数据，注意5678端口是Text协议的端口，Text协议需要在数据末尾加上换行符
// 	fwrite($client, json_encode($data)."\n");
// 	// 读取推送结果
// 	echo fread($client, 8192);
// 	if($i>99){
// 		$i=0;
// 	}
// 	sleep(1);
// }
$data = array('uid'=>'1', 'type'=>"pushOff");
// 	// 发送数据，注意5678端口是Text协议的端口，Text协议需要在数据末尾加上换行符
fwrite($client, json_encode($data)."\n");