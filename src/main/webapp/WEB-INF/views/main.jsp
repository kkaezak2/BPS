<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<title>BitPremiumSystem</title>
<link rel="icon" type="image/x-icon"
	href="/resources/images/favicon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 부트스트랩 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/cerulean/bootstrap.min.css">
<!-- 폰트어썸 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<!-- 스윗알럿 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- j쿼리 -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<!-- FullCalendar 라이브러리 -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<link href="fullcalendar-5.11.3/lib/main.css" rel="stylesheet" />

<!-- 부트스트랩 JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
	crossorigin="anonymous"></script>
<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/b1f4a63a6f.js"
	crossorigin="anonymous"></script>
<!-- 클래식 에디터 -->
<script
	src="https://cdn.ckeditor.com/ckeditor5/38.1.0/classic/ckeditor.js"></script>
<!-- 챗봇 -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.3.0/kakao.min.js"
	integrity="sha384-70k0rrouSYPWJt7q9rSTKpiTfX6USlMYjZUtr1Du+9o4cGvhPAWxngdtVZDdErlh"
	crossorigin="anonymous"></script>

<!-- 나머지 스크립트 및 스타일시트 -->
<link rel="stylesheet" type="text/css"
	href="/resources/css/employee.css">
<link rel="stylesheet" type="text/css" href="/resources/css/navbar.css">
<link rel="stylesheet" type="text/css" href="/resources/css/main.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/content-styles.css">
<script src="/resources/js/navbar.js"></script>

</head>


<body>

	<!-- 네비바 시작 -->
	<jsp:include page="/WEB-INF/views/navbar.jsp" />
	<!-- 네비바 끝 -->

	<div class="mt-5" id="div_body">

		<div class="row">
			<div class="grid-container">


				<!-- 일정뷰 시작 -->
				<div class="item1">
					<div class="card border" id="item1_card_border">
						<div class="card-header mt-3" id="item1_card_header">
							<h3>일정관리</h3>
						</div>
						<div class="card-body" id='calendar'></div>
						<!-- 일정뷰 끝 -->
					
					</div>


					<!-- 일정등록 모달시작 -->
					<div class="modal" id="addSchedule">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
								<form>
									<div class="modal-header">
										<h5 class="modal-title" id="titleForAddSchedule">
											<i class="fa-solid fa-square"></i>&nbsp;일정등록
										</h5>
									</div>

									<div class="modal-body">
										<div class="row mb-3">
											<label for="title"
												class="col-sm-3 col-form-label text-center">시작일자</label>
											<div class="col-9">
												<input type="date" class="form-control" name="start"
													id="start" placeholder="YYYY-MM-DD">
											</div>
										</div>


										<div class="row mb-3">
											<label for="title"
												class="col-sm-3 col-form-label text-center">종료일자</label>
											<div class="col-9">
												<input type="date" class="form-control" name="end" id="end"
													placeholder="YYYY-MM-DD">
											</div>
										</div>


										<div class="row">
											<label for="title"
												class="col-sm-3 col-form-label text-center">일정 </label>
											<div class="col-9">
												<input type="text" class="form-control" name="title"
													id="title" placeholder="">
											</div>
										</div>
									</div>


									<div class="modal-footer">
										<button type="button"
											onclick="addSchedule('${logInusername}',document.getElementById('title').value, document.getElementById('start').value, document.getElementById('end').value)"
											class="btn bg-dark text-white">등록</button>

										<button type="button" onclick="closeModal()"
											class="btn bg-white text-dark" data-bs-dismiss="modal">닫기</button>
									</div>
								</form>
							</div>
						</div>
					</div>

					<!-- 일정등록 모달 끝 -->

				</div>


				<!-- 나의업무현황영역 시작 -->

				<div class="item2">
					<div class="card border" id="item2_card_border">

						<div class="card-header mt-3" id="item2_card_header">
							<h3>나의 업무현황</h3>
						</div>


						<!-- 결재요청 시작 -->
						<div class="card-body fs-4" id="titleForAskPermit">
							결재요청&nbsp;


							<c:set var="statusCount" value="0" />
							<c:forEach items="${confirmAllList}" var="confirm">


								<c:if
									test="${confirm.status eq '결재요청' && confirm.username eq logInusername && logIngrade ne '팀장'}">
									<c:set var="statusCount" value="${statusCount + 1}" />
								</c:if>

								<c:if
									test="${confirm.status eq '결재요청' && confirm.teamName eq logInteamname && logIngrade eq '팀장'}">
									<c:set var="statusCount" value="${statusCount + 1}" />
								</c:if>

							</c:forEach>


							<c:choose>
								<c:when test="${confirmAllList != null}">
									<a href="/refund/confirmAll" id="forAskCount">${statusCount}건</a>
								</c:when>
								<c:otherwise>
   								 0건
  							</c:otherwise>
							</c:choose>

						</div>

						<!-- 결재요청 끝 -->


						<!-- 결재완료 시작 -->
						<div class="card-body fs-4" id="titleForAskPermit">
							결재완료&nbsp;
							<c:set var="statusCounts" value="0" />
							<c:forEach items="${confirmDoneList}" var="confirmDone">

								<c:if
									test="${confirmDone.status eq '결재완료' && confirmDone.approver eq logInname && logIngrade eq '팀장'}">
									<c:set var="statusCounts" value="${statusCounts + 1}" />
								</c:if>
								<c:if
									test="${confirmDone.status eq '결재완료' && confirmDone.name eq logInname && logIngrade ne '팀장'}">
									<c:set var="statusCounts" value="${statusCounts + 1}" />
								</c:if>

							</c:forEach>

							<c:choose>
								<c:when test="${confirmDoneList != null}">
									<span id="forAskCount2">${statusCounts}건</span>
								</c:when>
								<c:otherwise>
   								 0건
  							</c:otherwise>
							</c:choose>
						</div>

						<!-- 결재완료 끝 -->


						<!-- 결재반려 시작 -->
						<div class="card-body fs-4" id="titleForAskPermit">
							결재반려&nbsp;
							<c:set var="statusCounts" value="0" />
							<c:forEach items="${confirmDoneList}" var="confirmDone">

								<c:if
									test="${confirmDone.status eq '반려' && confirmDone.approver eq logInname && logIngrade eq '팀장'}">
									<c:set var="statusCounts" value="${statusCounts + 1}" />
								</c:if>
								<c:if
									test="${confirmDone.status eq '반려' && confirmDone.name eq logInname && logIngrade ne '팀장'}">
									<c:set var="statusCounts" value="${statusCounts + 1}" />
								</c:if>
							</c:forEach>

							<c:choose>
								<c:when test="${confirmDoneList != null}">
									<span id="forAskCount2">${statusCounts}건</span>
								</c:when>
								<c:otherwise>
   								 0건
  							</c:otherwise>
							</c:choose>

						</div>

						<!-- 결재반려 끝 -->


					</div>
				</div>
				<!-- 나의업무현황영역 끝 -->



				<!-- 공지사항영역 시작 -->
				<div class="item3">

					<div class="card border" id="item3_card_border">
						<div class="card-header mt-3 inline-block" id="item3_card_header">
							<h3>공지사항</h3>

							<a href="#" id="item3_modal_notice" data-bs-toggle="modal"
								data-bs-target="#modalNotice"> <span><i
									class="fa-solid fa-pen"></i></span>
							</a>

						</div>


						<div class="card-body fs-6 scroll">
							<div class="row text-center">
								<div class="col-1">NO</div>
								<div class="col">제목</div>
								<div class="col">작성자</div>
								<div class="col">작성일자</div>
							</div>

							<div class="row">
								<hr>

							</div>

							<c:forEach items="${noticeAllList }" var="notice">
								<div class="row mt-2 mb-2">

									<div class="col-1 text-center">${notice.id}</div>
									<div class="col" data-bs-toggle="modal"
										data-bs-target="#${notice.id}">${notice.title}</div>
									<div class="col text-center">${notice.writer}</div>
									<div class="col text-center">
										<fmt:formatDate value="${notice.entryDate}"
											pattern="yyyy-MM-dd" />
									</div>
								</div>


								<!-- 공지내용보기 모달 시작 -->

								<div class="modal" id="${notice.id}" tabindex="-1"
									aria-labelledby="exampleModalCenteredScrollableTitle">

									<div
										class="modal-dialog modal-dialog-centered modal-dialog-scrollable"
										role="document">
										<div class="modal-content">
											<div class="modal-header">

												<h5 class="modal-title" id="titleForNotice">
													<i class="fa-solid fa-circle-info"></i>&nbsp;공지사항
												</h5>

											</div>


											<div class="modal-body">
												<div class="row mb-3">
													<h3>&#91;&nbsp;${notice.title }&nbsp;&#93;</h3>
												</div>

												<div class="row">
													<hr>
												</div>

												<div class="card-subtitle mb-2 text-muted text-end">${notice.writer }&nbsp;
													<fmt:formatDate value="${notice.entryDate }"
														pattern="yyyy-MM-dd" />
												</div>

												<p>${notice.content }</p>


<div class="col-md-3" id="centered-image">                  
                     <c:if test="${not empty attachmentList}">
                        <c:forEach items="${attachmentList}" var="file">
                        <c:if test="${notice.id eq file.noticeId }">
                           <img src="/upload/${file.noticeId}/${file.path}">
                              </c:if>
                     </c:forEach>
                       
                     </c:if>
                  </div>


											</div>
											<div class="modal-footer">


												<c:if test="${notice.writerId eq logInusername }">
													<button type="button" class="btn bg-dark text-white"
														data-bs-toggle="modal"
														data-bs-target="#updateModal(${notice.id })"
														onclick="initCKEditorForUpdate('${notice.id}')">수정</button>

													<button type="button" class="btn bg-dark text-white"
														onclick="noticeDelete(${notice.id})">삭제</button>

												</c:if>

												<button type="button" class="btn bg-white text-dark"
													data-bs-dismiss="modal">닫기</button>

											</div>
										</div>
									</div>
								</div>



								<!-- 공지사항 수정 모달시작 -->
								<div class="modal" id="updateModal(${notice.id })">
									<div class="modal-dialog modal-dialog-centered" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="titleForUpdatenotice">
													<i class="fa-solid fa-square"></i>&nbsp;공지사항 수정
												</h5>

											</div>

											<form action="/updateNotice/${notice.id}" method="post">
												<div class="modal-body">


													<div class="row mb-3">
														<label for="title"
															class="col-sm-3 col-form-label text-center">제목</label>
														<div class="col-9">

															<input type="text" class="form-control" name="title"
																id="update_title" value="${notice.title }">

														</div>
													</div>


													<div class="row mb-3">
														<label for="title"
															class="col-sm-3 col-form-label text-center">내용</label>
														<div class="col-9">

															<textarea class="form-control" name="content"
																id="update_content">${notice.content}</textarea>


														</div>
													</div>



												</div>
												<div class="modal-footer">
													<button type="submit" class="btn bg-dark text-white">수정등록</button>
													<button type="button" class="btn bg-white text-dark"
														data-bs-dismiss="modal">닫기</button>

												</div>
											</form>
										</div>
									</div>
								</div>


								<!-- 공지사항 수정 모달끝 -->


							</c:forEach>


							<!-- 공지내용보기 모달 끝 -->




							<!-- 공지등록 모달시작 -->

							<div class="modal" id="modalNotice">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<form action="/notice" method="post" enctype="multipart/form-data" id="form-file">

											<div class="modal-header">
												<h5 class="modal-title" id="titleForAddNotice">
													<i class="fa-solid fa-square"></i>&nbsp;공지사항등록
												</h5>

											</div>

											<div class="modal-body">


												<div class="row">
													<label for="title"
														class="col-sm-3 col-form-label text-center">제목 </label>
													<div class="col-9">
														<input type="text" class="form-control" name="title"
															id="notice_title" placeholder="">
													</div>
												</div>

												<div class="row mt-3">
													<label for="content"
														class="col-sm-3 col-form-label text-center">내용 </label>
													<div class="col-9">
														<!-- CKEditor로 작성한 내용을 textarea에 적용 -->
														<textarea class="form-control" name="content" id="content"></textarea>
														<input type="hidden" value="${logInusername}" name="writerId">
                                                        <input type="hidden" value="${logInname}" name="writer">
														
                                               <input class="form-control" type="file" name="file" id="formFile" multiple="multiple">


													</div>
												</div>
											</div>


						<div class="modal-footer">
							
							<button type="button" onclick="addNotice()"	class="btn bg-dark text-white">등록</button>
							
						<button type="button" onclick="closeModal()"
							class="btn bg-white text-dark" data-bs-dismiss="modal">닫기</button>
					</div>
				</form>
			</div>
								</div>
							</div>

							<!-- 공지등록 모달 끝 -->

						</div>
					</div>
				</div>
				<!-- 공지사항영역 끝 -->




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
									<button type="button"
										onclick="checkPassword('${logInusername}')"
										class="btn bg-dark text-white">변경</button>

									<button type="button" class="btn bg-white text-dark"
										data-bs-dismiss="modal">취소</button>
								</div>
							</form>
						</div>

					</div>
				</div>
				<!-- 비밀번호 변경모달 끝 -->




				<!-- 챗봇 아이콘 시작 -->
				<div id="chatPopup" class="chat-popup2">
					<a id="chat-channel-button" href="javascript:chatChannel()"> <img
						src="/resources/images/ruok.png" id="chatImage2"
						alt="업무처리 Chat bot" title="BPQ :)" />
					</a>
				</div>
				<!-- 챗봇 아이콘 끝 -->


			</div>
		</div>


		<script src="/resources/js/main.js"></script>
	</div>

</body>
</html>