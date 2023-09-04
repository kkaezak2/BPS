<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<title>BitPremiumSystem</title>
<link rel="icon" type="image/x-icon"
	href="/resources/images/favicon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 부트스트랩 -->
<link
	href="
https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/cerulean/bootstrap.min.css
"
	rel="stylesheet">
<!-- 부트스트랩 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
	crossorigin="anonymous"></script>
<!-- j쿼리 -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- 스윗알럿 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/b1f4a63a6f.js"
	crossorigin="anonymous"></script>
<!-- 부트스와치_테마 -->
<link rel="stylesheet"
	href="https://bootswatch.com/5/cosmo/bootstrap.min.css">

<!-- css파일 -->
<link rel="stylesheet" type="text/css" href="/resources/css/index.css">
<!-- js파일 -->
<script src="/resources/js/index.js"></script>

</head>

<body>

	<button class="open-button" onclick="openForm()">로그인</button>

<!-- 로그인 bgm시작 -->
	<audio id="loginSound" src="/resources/bgm/wow3.mp3" preload="auto"></audio>
<!-- 로그인 bgm끝 -->

	<div class="form-popup" id="myForm">

		<form action="/employee/auth" method="post" class="form-container">

			<input type="text" placeholder="사번" name="username" required>
			<input type="password" placeholder="비밀번호" name="password" required>

			<button type="button" class="btn" onclick="playSoundAndSubmit()">로그인</button>

			<button onclick="closeForm()" class="btn close">닫기</button>
		</form>
	</div>

</body>
</html>