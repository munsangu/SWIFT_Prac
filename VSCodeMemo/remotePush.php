<?php

	$idxNum = $_GET['idx'];
	$searchSQL = "";
	$pushContent = array();

	$conn = mysqli_connect('myAddress', 'ID', 'PASSWORD', 'DB');

	if ($idxNum == -1){
		$searchSQL = "SELECT * FROM testtable WHERE token != ''";
		$pushContent = array('title' => '토스 타임💡', 'body' => "다들 Toss를 켜볼까요??📱",'sound' => 'default', 'url' => 'supertoss://toss/pay');
	} else if ($idxNum == -2){
		$searchSQL = "SELECT * FROM testtable WHERE token != ''";
		$pushContent = array('title' => '점심 시간🍽️', 'body' => "밥 먹으러 가실까요??🍚", 'sound' => 'default');
	} else if ($idxNum == -3){
		$searchSQL = "SELECT * FROM testtable WHERE token != ''";
		$pushContent = array('title' => '접근 감지🚨', 'body' => "누군가가 사무실로 오고있네요??🐥", 'sound' => 'default');
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
	$result = curl_exec($curl);

	// Check for errors
	if ($result === false) {
		die('cURL error: ' . curl_error($curl));
	} else {
		$sql = "
			INSERT INTO testtable
			(created) VALUES
			(now())
		";
		mysqli_query($conn, $sql);
	}

	// Close the cURL handle
	curl_close($curl);

	// Output the result
	// echo $result;
	

?>

<script>
setTimeout(function() {
  window.history.back();
}, 500);
</script>