<?php

	$idxNum = $_GET['idx'];
	$userName = $_GET['userName'];
	$searchSQL = "";
	$updateSQL = "";
	$pushContent = array();

	$conn = mysqli_connect('myAddress', 'ID', 'PASSWORD', 'DB');

	if ($idxNum == -1){
		$searchSQL = "SELECT * FROM testtable WHERE token != ''";
		$pushContent = array('title' => '토스 타임💡', 'body' => "[{$userName}] 다들 Toss를 켜볼까요??📱",'sound' => 'default', 'url' => 'supertoss://toss/pay');
		$updateSQL = "UPDATE alertCheckTable SET tossAlertUsed = 1, tossAlertFirstUserName = '{$userName}', tossAlertFirstDate = DATE_ADD(NOW(), INTERVAL 9 HOUR) WHERE idx = 1";
	} else if ($idxNum == -2){
		$searchSQL = "SELECT * FROM testtable WHERE token != ''";
		$pushContent = array('title' => '점심 시간🍽️', 'body' => "[{$userName}] 밥 먹으러 가실까요??🍚", 'sound' => 'default');
		$updateSQL = "UPDATE alertCheckTable SET lunchAlertUsed = 1, lunchAlertFirstUserName = '{$userName}', lunchAlertFirstDate = DATE_ADD(NOW(), INTERVAL 9 HOUR) WHERE idx = 1";
	} else if ($idxNum == -3){
		$searchSQL = "SELECT * FROM testtable WHERE token != ''";
		$pushContent = array('title' => '접근 감지🚨', 'body' => "[{$userName}] 누군가가 사무실로 오고있네요??🐥", 'sound' => 'default');
	}

	$fcmToken = array();
	$result = mysqli_query($conn, $searchSQL);

	if ($result) {
		while($row = $result -> fetch_assoc()) {
			$fcmToken[] = $row['token'];
		}
	}

	$fields = array(
		'registration_ids' => array(
			'FCM TOKEN',
		),
		// 'registration_ids' => $fcmToken,
		'notification' => $pushContent,
	);


	$apiEndpoint = 'https://fcm.googleapis.com/fcm/send';
	$authorizationKey = 'SERVER KEY';
	$headers = array(
		'Authorization: key=' . $authorizationKey,
		'Content-Type: application/json'
	);

	// Create a cURL handle for the request
	$curl = curl_init();

	// Set the cURL options
	curl_setopt($curl, CURLOPT_URL, $apiEndpoint);
	curl_setopt($curl, CURLOPT_POST, true);
	curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($fields));

	// Send the request
	$result2 = curl_exec($curl);

	// Check for errors
	if ($result2 === false) {
		die('cURL error: ' . curl_error($curl));
	} else {
		mysqli_query($conn, $updateSQL);
	}

	// Close the cURL handle
	curl_close($curl);

	// Output the result
	// echo $result;
	

?>