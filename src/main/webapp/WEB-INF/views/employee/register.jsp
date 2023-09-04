<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">

<title>BitPremiumSystem</title>
 <link rel="icon" type="image/x-icon" href="/resources/images/favicon.ico">
 
<meta name="viewport" content="width=device-width, initial-scale=1"> 
 
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/b1f4a63a6f.js" crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- 부트스트랩 -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
	crossorigin="anonymous"></script>
	
<!-- 부트스와치_테마 -->
<link rel="stylesheet"
	href="https://bootswatch.com/5/cosmo/bootstrap.min.css">
		
<!-- css파일 -->
<link rel="stylesheet" type="text/css" href="/resources/css/employee.css">
<link rel="stylesheet" type="text/css" href="/resources/css/navbar.css">
<link rel="stylesheet" type="text/css" href="/resources/css/register.css">
<!-- js파일 -->
<script src="/resources/js/navbar.js"></script>
<script src="/resources/js/register.js"></script>

</head>

<body>
	<!-- 네비바 시작 -->
<jsp:include page="/WEB-INF/views/navbar.jsp" />
	<!-- 네비바 끝 -->

	
		<div class="mt-5" id="div_body">
		
		
	<form>
		
		<div class="row">
		<div class="col-12"><h3>
				<i class="fa-solid fa-stop"></i>&nbsp;직원등록
			</h3></div>
			</div>
		
		<div class="row">
		<div class="col-12">
		
		</div>
		</div>
		
		
		<div class="row mt-5 mb-3 justify-content-center">
		<div class="col-10">
		
		<label for="username"><b>사번</b></label> 
		<input type="text" class="r_input" placeholder="Username" id="username" name="username" maxlength="4" required>
		</div>
		</div>
		
	<div class="row mb-3 justify-content-center">
		<div class="col-10">
		<label for="password"><b>비밀번호</b></label>
		<input type="password" class="r_input" placeholder="Password" id="register-password" name="password" required>
		</div>
		</div>
		
		
		<div class="row mb-3 justify-content-center">
		<div class="col-10">
		<label for="name"><b>직원명</b></label>
		<input type="text" class="r_input" placeholder="Name" id="name" name="name" required>
		</div>
		</div>
		
		
		<div class="row mb-3 justify-content-center">
		<div class="col-10">
		<label for="teamCode"><b>부서코드</b></label>
		<input type="text" class="r_input" placeholder="Teamcode" id="teamCode" name="teamCode" maxlength="6" required>
		</div>
		</div>
		
		<div class="row mb-3 justify-content-center">
		<div class="col-10">
		<label for="teamName"><b>부서명</b></label>
		<input type="text" class="r_input" placeholder="Teamname" id="teamName" name="teamName" required>
		</div>
		</div>
		
		
		<div class="row justify-content-center">
		<div class="col-10">
			<div class="clearfix">
				<button type="reset" class="cancelbtn">입력취소</button> 
	
	<button type="button" onclick="startRegistration()" class="signupbtn custom">등록하기</button>
	</div> 
		</div>
	
		</div>
		</form>
		
		<!-- 비밀번호 변경모달 시작 -->

				<div class="modal" id="${logInusername}">

					<div class="modal-dialog justify-content-center modal-dialog-centered" role="document">
						<div class="modal-content">

								<div class="modal-header">
									<h5 class="modal-title" id="titleForPwd">
										<i class="fa-solid fa-square"></i>&nbsp;비밀번호 변경
									</h5>
								</div>
							<form>
								<div class="modal-body">

									<div class="row mb-3">
										<label for="title" class="col-sm-3 col-form-label text-center">변경비밀번호</label>
										<div class="col-9">

											<input type="password" class="form-control border-dark"
												name="modify_password" id="modify_password" placeholder="영문, 숫자조합으로 6자리이상">
										</div>
									</div>

									<div class="row">
										<label for="title" class="col-sm-3 col-form-label text-center">비밀번호확인</label>
										<div class="col-9">
											<input type="password" class="form-control" name="modify_password2" id="modify_password2">
										</div>
									</div>
								</div>

								<div class="modal-footer">
									<button type="button" onclick="checkPassword('${logInusername}')" class="btn bg-dark text-white">변경</button>

									<button type="button" class="btn bg-white text-dark"
										data-bs-dismiss="modal">취소</button>
								</div>
					</form>
						</div>
						
					</div>
				</div>
			<!-- 비밀번호 변경모달 끝 -->
		
		
		</div>
		

</body>
</html>