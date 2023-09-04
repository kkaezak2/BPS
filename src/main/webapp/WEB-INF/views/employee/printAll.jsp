<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- css파일 -->
<link rel="stylesheet" type="text/css"
	href="/resources/css/employee.css">
<link rel="stylesheet" type="text/css" href="/resources/css/navbar.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/employee_printAll.css">

<!-- js파일 -->
<script src="/resources/js/navbar.js"></script>
<script src="/resources/js/employee_printAll.js"></script>

</head>

<body>


	<!-- 네비바 시작 -->
	<jsp:include page="/WEB-INF/views/navbar.jsp" />
	<!-- 네비바 끝 -->

	<div class="mt-5" id="div_body">

		<!-- 조회영역 시작 -->

		<div class="row text-center justify-content-center">
			<div class="col-12 colheader d-flex">

				<form class="d-flex" action="/employee/search">
					<input class="form-control me-sm-2" id="input_searchForm"
						type="search" name="search" value="" required>

					<button class="btn bg-dark text-white my-2 my-sm-0" id="buttonFind"
						placeholder="" type="submit">조회</button>
				</form>

			</div>

		</div>
		<!-- 조회영역 끝 -->



		<!-- 헤더시작 -->
		<div class="row mt-5">
			<div class="col-11">
				<h3>
					<i class="fa-solid fa-stop"></i>&nbsp;직원정보
				</h3>
			</div>

			<div class="col-1">
				<c:if test="${logInteamname eq '인사혁신팀' }">
					<button type="button" class="btn bg-dark text-white"
						onclick="location.href='/employee/register'">직원등록</button>

				</c:if>

			</div>

		</div>
		<!-- 헤더 끝 -->


		<!-- 본문 헤더 시작 -->
		<c:choose>
			<c:when test="${logInteamname eq '인사혁신팀'}">

				<div class="row text-center mt-3" id="div_employeeHeader">
					<div class="col-2">사번</div>
					<div class="col-2">직원명</div>
					<div class="col-2">부서코드</div>
					<div class="col-2">부서명</div>
					<div class="col-2">직책</div>
					<div class="col-1">수정</div>
					<div class="col-1">삭제</div>

				</div>
				<!-- 본문 헤더 끝 -->


				<!-- 본문 내용 시작 -->
				<div class="row border text-center justify-content-center">

					<c:forEach items="${list}" var="emplist">

						<div class="col-2 custom-col">${emplist.username}</div>
						<div class="col-2 custom-col">${emplist.name}</div>
						<div class="col-2 custom-col">${emplist.teamCode}</div>
						<div class="col-2 custom-col">${emplist.teamName}</div>
						<div class="col-2 custom-col">${emplist.grade}</div>
						<div class="col-1 custom-col">
							<button type="button" class="btn bg-dark text-white btn-sm"
								data-bs-toggle="modal" data-bs-target="#emp_${emplist.username}">수정</button>
						</div>
						<div class="col-1 custom-col">
							<button type="button" class="btn bg-dark text-white btn-sm"
								onclick='confirmDelete("${emplist.username}")'>삭제</button>
						</div>


						<!-- 수정모달 시작 -->

						<div class="modal" id="emp_${emplist.username }">
							<div class="modal-dialog modal-dialog-centered" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">
											<i class="fa-solid fa-square"></i>&nbsp;직원정보 수정
										</h5>

									</div>
									<form action="/employee/updateGrade/${emplist.username }"
										method="post" id="alertForUpdateEmployee">
										<div class="modal-body">


											<div class="row mb-3">
												<label for="title"
													class="col-sm-3 col-form-label text-center">부서코드</label>
												<div class="col-9">

													<input type="text" class="form-control" name="teamCode"
														id="teamCode" value="${emplist.teamCode }">
												</div>
											</div>


											<div class="row mb-3">
												<label for="title"
													class="col-sm-3 col-form-label text-center">부서명</label>
												<div class="col-9">
													<input type="text" class="form-control" name="teamName"
														id="teamName" value="${emplist.teamName }">
												</div>
											</div>

											<div class="row mb-3">
												<label for="title"
													class="col-sm-3 col-form-label text-center">직원명 </label>
												<div class="col-9">
													<input type="text" class="form-control" name="name"
														id="name" value="${emplist.name }" disabled>
												</div>
											</div>


											<div class="row">
												<label for="title"
													class="col-sm-3 col-form-label text-center">직책 </label>
												<div class="col-9">
													<input type="text" class="form-control" name="grade"
														id="grade" value="${emplist.grade }">
												</div>
											</div>


										</div>
										<div class="modal-footer">
											<button type="submit" class="btn bg-dark text-white">수정</button>
											
											<button type="button" class="btn bg-white text-dark"
												data-bs-dismiss="modal">취소</button>
										</div>
									</form>
								</div>
							</div>
						</div>
						<!-- 수정모달 끝 -->

					</c:forEach>

				</div>
				<!-- 본문 내용 끝 -->
			</c:when>

			<c:otherwise>
				<!-- 본문 헤더2 시작 -->
				<div class="row text-center mt-3" id="div_employeeHeader">
					<div class="col-2">사번</div>
					<div class="col-2">직원명</div>
					<div class="col-3">부서코드</div>
					<div class="col-3">부서명</div>
					<div class="col-2">직책</div>
				</div>


				<!-- 본문 헤더2 끝 -->


				<!-- 본문 내용2 시작 -->
				<div class="row border text-center justify-content-center">

					<c:forEach items="${list}" var="emplist">

						<div class="col-2 custom-col">${emplist.username}</div>
						<div class="col-2 custom-col">${emplist.name}</div>
						<div class="col-3 custom-col">${emplist.teamCode}</div>
						<div class="col-3 custom-col">${emplist.teamName}</div>
						<div class="col-2 custom-col">${emplist.grade}</div>


					</c:forEach>

				</div>
				<!-- 본문 내용2 끝 -->

			</c:otherwise>
		</c:choose>




		<!-- 페이지네이션 시작 -->
		<div class="row">

			<div class="col text-center mt-3">
				<div class="col text-dark">
					<ul class="pagination pagination-sm text-dark">

						<li class="page-item text-dark"><a
							class="page-link text-dark" href="/employee/printAll/1">&laquo;</a></li>

						<c:forEach begin="${startPage}" end="${endPage}" var="page">
							<li class="page-item text-dark"><a
								class="page-link text-dark" href="/employee/printAll/${page}">${page}</a></li>
						</c:forEach>

						<li class="page-item text-dark"><a
							class="page-link text-dark" href="/employee/printAll/${maxPage}">&raquo;</a></li>
					</ul>
				</div>

			</div>

		</div>

		<!-- 페이지네이션 끝 -->

		<!-- 비밀번호 변경모달 시작 -->

		<div class="modal" id="${logInusername }">

			<div
				class="modal-dialog justify-content-center modal-dialog-centered"
				role="document">
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
										name="modify_password" id="modify_password"
										placeholder="영문, 숫자조합으로 6자리이상">
								</div>
							</div>

							<div class="row">
								<label for="title" class="col-sm-3 col-form-label text-center">비밀번호확인</label>
								<div class="col-9">
									<input type="password" class="form-control"
										name="modify_password2" id="modify_password2">
								</div>
							</div>
						</div>

						<div class="modal-footer">
							<button type="button" onclick="checkPassword('${logInusername}')"
								class="btn bg-dark text-white">변경</button>

							<button type="button" class="btn bg-white text-dark"
								data-bs-dismiss="modal">취소</button>
						</div>
					</form>
				</div>

			</div>
		</div>
		<!-- 비밀번호 변경모달 끝 -->



		<!-- 찍어봄? 시작 -->
		<div id="imagePopup" class="image-popup">
			<img src="/resources/images/rucok.png" id="manImage" title="!_!" />
		</div>
		<!-- 찍어봄? 끝 -->


	</div>


</body>
</html>