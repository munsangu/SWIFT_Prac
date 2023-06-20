<?php
	$fcmToken = isset($_GET['fcmToken']) ? $_GET['fcmToken'] : '';

	$today = date("Y-m-d");

	$conn = mysqli_connect('myAddress', 'ID', 'PASSWORD', 'DB');
	$tokenSearch = "SELECT * FROM testtable WHERE token = '{$fcmToken}'";
	
	$result = mysqli_query($conn, $tokenSearch);

	if ($result) {
		while($row = $result -> fetch_assoc()) {
			if($fcmToken == $row['token']) {
				$name1 = $row['name'];
				$token1 = $row['token'];
				header("Location: index2.php?userName=$name1&name=$token1");
			}
		}
	}

	if ($_SERVER['REQUEST_METHOD'] === 'POST') {
		$token = $_POST['token'];
		$name = $_POST['name'];
		$encodedName = urlencode($name);
		header("Location: index2.php?userName=$encodedName&name=$token");
		exit;
	}
?>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>My App</title>
	<link rel="stylesheet" type="text/css" href="style3.css"/>
</head>
<body>
	<form method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>">
	<div class="blurred-box">
	 <div class="user-login-box">
		<span class="user-icon"></span>
		<div class="user-name">토스타임</div>
		<input class="user-password" name="name" type="text" placeholder="영어이름 축약형(e.g. HGD) 기입"/>
		<input type="hidden" name="token" value="<?php echo $fcmToken; ?>">
	   <button id="nameCheck">들어가기</button>
	  </div>
	</div>
	</form>
</body>
<script>
	
	var input = document.querySelector('input[name="name"]')
	var button = document.querySelector('#nameCheck')
	
	button.addEventListener("click", () => {
			var inputValue = input.value
			if (!isEnglishLowercase(inputValue)) {
			alert("입력한 이름이 올바르지 않습니다");
			event.preventDefault();
		}
	})
	
	function isEnglishLowercase(text) {
	  var englishRegex = /^[A-Z]+$/;
	  return englishRegex.test(text);
	}	
</script>
</html>