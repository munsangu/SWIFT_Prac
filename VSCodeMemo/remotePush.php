<?php
	$conn = mysqli_connect('myAddress', 'ID', 'PASSWORD', 'DB');

	$idxNum = $_GET['idx'];
	$userName = $_GET['userName'];
	$today = date("Y-m-d");

	$searchSQL = "";
	$updateSQL = "";
	$pushContent = array();

	if ($idxNum == -1){
		$searchSQL = "SELECT * FROM testtable WHERE token != ''";
		$pushContent = array('title' => 'FisrstTitle', 'body' => "[{$userName}] FirstBody",'sound' => 'default', 'url' => 'supertoss://toss/pay');
		$updateSQL = "UPDATE alertCheckTable SET tossAlertUsed = 1, tossAlertFirstUserName = '{$userName}', tossAlertFirstDate = NOW() WHERE DATE(date) = '{$today}'";
	} else if ($idxNum == -2){
		$searchSQL = "SELECT * FROM testtable WHERE token != ''";
		$pushContent = array('title' => 'SecondTitle', 'body' => "[{$userName}] SecondBody", 'sound' => 'default');
		$updateSQL = "UPDATE alertCheckTable SET lunchAlertUsed = 1, lunchAlertFirstUserName = '{$userName}', lunchAlertFirstDate = NOW() WHERE DATE(date) = '{$today}'";
	} else if ($idxNum == -3){
		$searchSQL = "SELECT * FROM testtable WHERE token != ''";
		$pushContent = array('title' => 'ThirdTitle', 'body' => "[{$userName}] ThirdBody", 'sound' => 'default');
		$updateSQL = "INSERT INTO visitAlertCheck (visitAlertFirstUserName, date) VALUES ('{$userName}', now())"; 
	}

	$fcmToken = array();
	$result = mysqli_query($conn, $searchSQL);

	if ($result) {
		while($row = $result -> fetch_assoc()) {
			$fcmToken[] = $row['token'];
		}
	}

	$fields = array(
		'registration_ids' => $fcmToken,
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