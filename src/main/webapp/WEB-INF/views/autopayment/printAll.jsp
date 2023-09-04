<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>BitPremiumSystem</title>
 <link rel="icon" type="image/x-icon" href="/resources/images/favicon.ico">


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
	href="/resources/css/autopayment_printAll.css">
<!-- js파일 -->
<script src="/resources/js/navbar.js"></script>
<script src="/resources/js/autopayment_printAll.js"></script>

</head>


<body>

	<!-- 네비바 시작 -->
	<jsp:include page="/WEB-INF/views/navbar.jsp" />
	<!-- 네비바 끝 -->

	<div class="mt-5" id="div_body">

		<div class="row justify-content-center">



			<!-- 주민등록번호 조회영역 시작 -->
			<div class="col-5 colheader d-flex">

				<form class="d-flex" action="/autopayment/printAll" method="post">
					<input class="form-control me-sm-2" name="ssn" id="ssn" value=""
						placeholder="주민등록번호" minlength="13" maxlength="13" required>
					<button class="btn bg-dark text-white ml-2 mr-4" type="submit">조회</button>
				</form>
			</div>
			<!-- 주민등록번호 조회영역 끝 -->


			<!-- 증서번호 조회영역 시작 -->
			<div class="col-5 colheader d-flex">
				<form class="d-flex" action="/autopayment/printOne" method="post">
					<input class="form-control me-sm-2" id="input_number" name="number"
						value="" placeholder="증서번호" minlength="10" maxlength="10" required>

					<button class="btn bg-dark text-white ml-2 mr-4" type="submit">조회</button>
				</form>
			</div>
			<!-- 증서번호 조회영역 끝 -->


			<!-- 고객명출력 시작 -->
			
       <div class="col-2 colheader d-flex" id="col2_customerName">         
         
         <c:set value="${emptyResult}" var="result" />
             <c:if test="${result eq false}">
              <c:forEach items="${contractList}" var="contract" varStatus="loopStatus">
            <c:if test="${loopStatus.index == 0}">
                <span class="fs-6" id="span_customerName">고객명&nbsp;|&nbsp;${contract.contractor}</span>
            </c:if>
            </c:forEach>
            </c:if>
            
             <c:if test="${result eq true}">
               <span class="fs-6" id="span_customerName2">조회결과없음</span>
             </c:if>             
             
        </div>
			
			<!-- 고객명출력 끝 -->


			<!-- 계약정보 헤더 시작 -->
			<div class="row mt-5">
				<div class="col-12">
					<h3>
						<i class="fa-solid fa-stop"></i>&nbsp;계약정보
					</h3>
				</div>
			</div>
			<!-- 계약정보 헤더 끝 -->



			<!-- 계약정보 본문 시작 -->
			<!-- 계약정보 본문(헤더) 시작 -->
			<div class="row text-center mt-3 hover" id="div_contract_header">
				<div class="col-2">증서번호</div>
				<div class="col-2">상품명</div>
				<div class="col-1">보험료</div>
				<div class="col-1">계약상태</div>
				<div class="col-1">납입방법</div>
				<div class="col-1">자동이체일자</div>
				<div class="col-2">은행명</div>
				<div class="col-2">계좌번호</div>
			</div>
			<!-- 계약정보 본문(헤더) 끝 -->


			<!-- 구분선 시작 -->
			<div class="row">
				<div class="col-12">
					<hr>
				</div>
			</div>
			<!-- 구분선 끝 -->



			<!-- 계약정보 본문(내용) 시작 -->

<div class="combined-scroll">

			<c:forEach items="${combinedList}" var="combined" varStatus="status">

			 <div class="row text-center" ondblclick='showAllRows("row_${combined.number}", ${json})' id='row_${combined.number }'> 
     

					<div class="col-2 custom-col">${combined.number}</div>
					<div class="col-2 custom-col">${combined.productName}</div>
					<div class="col-1 custom-col">

						<fmt:formatNumber value="${combined.premium}" type="number"
							pattern="#,###" />
					</div>
					<div class="col-1 custom-col">${combined.status}</div>
					<div class="col-1 custom-col">${combined.paymentMethod}</div>
					<div class="col-1 custom-col">${combined.accountDate}</div>
					<div class="col-2 custom-col">${combined.bank}</div>
					<div class="col-2 custom-col">
						<c:choose>
							<c:when test="${combined.account == 0}"></c:when>
							<c:otherwise>${combined.account}</c:otherwise>
						</c:choose>
					</div>
				</div>
			</c:forEach>
			</div>
			<!-- 계약정보 본문(내용) 끝 -->
			<!-- 계약정보 본문 끝 -->



			<!-- 자동이체변경 헤더 시작 -->
			<div class="row mt-5">
				<div class="col-12">
					<h3>
						<i class="fa-solid fa-stop"></i>&nbsp;자동이체변경
					</h3>
				</div>
			</div>
			<!-- 자동이체변경 헤더 끝 -->


			<!-- 자동이체 본문 시작 -->
			<!-- 자동이체 본문(헤더) 시작 -->
			<form id="autopaymentForm">
				<div class="row text-center mt-3">
					<div class="col-2">증서번호</div>
					<div class="col-2">상품명</div>
					<div class="col-1">보험료</div>
					<div class="col-1">계약상태</div>
					<div class="col-2">업무구분</div>
					<div class="col-2">자동이체날짜</div>
					<div class="col-2">계좌정보</div>

				</div>
				<!-- 자동이체 본문(헤더) 끝 -->

				<!-- 구분선 시작 -->
				<div class="row">
					<div class="col-12">
						<hr>
					</div>
				</div>
				<!-- 구분선 끝 -->



				<!-- 자동이체 본문(내용) 시작 -->
				<div class="row text-center clone" id="div_row_autopayment">

					<!-- 클론이 들어갈 영역 -->
				</div>


			</form>
			<!-- 자동이체 본문(내용) 끝 -->

			<!-- 자동이체 본문 끝 -->


			<!-- 변경버튼 시작 -->
			<div class="row">

<!-- 버튼명:계좌등록 시작 -->
<div class="col-6 text-start">
	<button type="button" onclick="()" class="btn border bg-white text-dark mt-3" data-bs-toggle="modal" data-bs-target="#bankModal"
	<c:if test="${empty combinedList}">disabled</c:if>
	>계좌등록</button>

</div>
				
				<!-- 버튼명:계좌등록 끝 -->
				<!-- 버튼명:변경 시작 -->
				<div class="col-6 text-end">
					<button type="button" onclick="autopayment()"
						class="btn bg-dark text-white mt-3"
						<c:if test="${empty combinedList}">disabled</c:if>
						>변경</button>

				</div>
				<!-- 버튼명:변경 끝 -->



			</div>
			<!-- 변경버튼 끝 -->
		</div>


		<!-- 계좌등록 모달 시작 -->
		<div class="modal fade" id="bankModal" tabindex="-1" role="dialog"
			aria-labelledby="bankModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content" id="addAccountModal">
					<div class="modal-header">
						<h5 class="modal-title" id="bankModalLabel">
							<i class="fa-solid fa-stop"></i>&nbsp;계좌정보 등록
						</h5>

					</div>
					<div class="modal-body">

						<!-- 은행명 입력 필드 -->
						
          <div class="form-group mb-3">
           <label for="forbanklabel">은행</label>          
            
            <div class="btn-group mb-2 d-flex" role="group" id="forbanklabel" aria-label="Basic radio toggle button group">
            
           <input type="radio" class="btn-check" name="bank" id="btnradio1" value="신한" autocomplete="off">
           <label class="btn text-dark outline-light label_with_image" id="label_btnradio1" for="btnradio1">
           <img src = "/resources/images/shinhan.png" class="imgradio" >
           신한
           </label>
           
           <input type="radio" class="btn-check" name="bank" id="btnradio2" value="국민" autocomplete="off">
           <label class="btn text-dark outline-light label_with_image" id="label_btnradio2" for="btnradio2">
           <img src = "/resources/images/kb.png" class="imgradio" >
           국민
           </label>
           
           <input type="radio" class="btn-check" name="bank" id="btnradio3" value="우리" autocomplete="off">
           <label class="btn text-dark outline-light label_with_image" id="label_btnradio3" for="btnradio3">
           <img src = "/resources/images/woori.png" class="imgradio">
           우리
           </label>
           
           <input type="radio" class="btn-check" name="bank" id="btnradio4" value="하나" autocomplete="off">
           <label class="btn text-dark outline-light label_with_image" id="label_btnradio4" for="btnradio4">
           <img src = "/resources/images/hana.png" class="imgradio" >
           하나
           </label>
           
           <input type="radio" class="btn-check" name="bank" id="btnradio5" value="기업" autocomplete="off">
           <label class="btn text-dark outline-light label_with_image" id="label_btnradio5" for="btnradio5">
           <img src = "/resources/images/ibk.png" class="imgradio" >
           기업
           </label>
           
           <input type="radio" class="btn-check" name="bank" id="btnradio6" value="농협" autocomplete="off">
           <label class="btn text-dark outline-light label_with_image" id="label_btnradio6" for="btnradio6">
           <img src = "/resources/images/nonghyup.png" class="imgradio" >
           농협
           </label>
        
        </div>
       </div> 
         
				
						
						<!-- 계좌번호 입력 필드 -->
						<div class="form-group mt-1 mb-3">
							<label for="account">계좌번호</label>
							 <input type="text"
								class="form-control bankinput" id="account"
								placeholder="1234567" required>
						</div>
						<!-- 예금주 입력 필드 -->
						<div class="form-group mb-3">
							<label for="depositor">예금주</label> <input type="text"
								class="form-control bankinput" id="depositor" placeholder="김비트"
								required>
						</div>

						<!-- 예금주 주민번호 필드 -->
						<div class="form-group mb-3">
							<label for="depositorSsn">예금주&nbsp;주민번호</label> <input
								type="text" class="form-control bankinput" id="depositorSsn"
								placeholder="8111111222222" minlength="13" maxlength="13" required>
						</div>

						<!-- 계약자 주민번호 필드 -->
						<div class="form-group mb-3">
                        
                        
                         <c:set var="contract" value="${contractList}" />                  
                     <label for="ssn1">계약자&nbsp;주민번호</label> 
                     <input type="text"
                        class="form-control bankinput" id="ssn1" value="${contract[0].ssn}" minlength="13" maxlength="13" required>
                        
                  </div>
						
						

					</div>
				<!-- 모달 내 버튼영역 시작 -->
					<div class="modal-footer">
						<button type="button" class="btn bg-dark text-white"
							onclick="bankRegistration()">저장</button>
						<button type="button" class="btn bg-white text-dark"
							data-bs-dismiss="modal">취소</button>
					</div>
					<!-- 모달 내 버튼영역 끝 -->


				</div>
			</div>
		</div>
		<!-- 계좌등록 모달 끝 -->
		
		
		
		<!-- 비밀번호 변경모달 시작 -->

				<div class="modal" id="${logInusername }">

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