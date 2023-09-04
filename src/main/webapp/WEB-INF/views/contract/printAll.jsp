<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<link rel="stylesheet" type="text/css" href="/resources/css/employee.css">
<link rel="stylesheet" type="text/css" href="/resources/css/navbar.css">
<link rel="stylesheet" type="text/css" href="/resources/css/contract_printAll.css">
<!-- js파일 -->
<script src="/resources/js/navbar.js"></script>
<script src="/resources/js/contract_printAll.js"></script>

</head>


<body>


   <!-- 네비바 시작 -->
   <jsp:include page="/WEB-INF/views/navbar.jsp" />
   <!-- 네비바 끝 -->


   <div class="mt-5" id="div_body">

      <div class="row justify-content-center">

         <!-- 주민등록번호 조회영역 시작 -->
         <div class="col-5 colheader d-flex">

            <form class="d-flex" action="/contract/printAll" method="post">
               <input class="form-control me-sm-2" name="ssn" id="ssn" value=""
                  placeholder="주민등록번호" minlength="13" maxlength="13" required>

               <button class="btn bg-dark text-white ml-5 mr-5" type="submit">조회</button>
            </form>
         </div>
         <!-- 주민등록번호 조회영역 끝 -->



         <!-- 증서번호 조회영역 시작 -->
         <div class="col-5 colheader d-flex">
            <form class="d-flex" action="/contract/printOne" method="post">
               <input class="form-control me-sm-2" name="number" id="find_number"
                  value="" placeholder="증서번호" minlength="10" maxlength="10" required>

               <button class="btn bg-dark text-white ml-2 mr-4" type="submit">조회</button>
            </form>

         </div>

         <!-- 증서번호 조회영역 끝 -->



         <!-- 고객명출력영역 시작 -->
    
       <div class="col-2 colheader d-flex" id="col_customer_report">         
         
         <c:set value="${emptyResult}" var="result" />
             <c:if test="${result eq false}">
              <c:forEach items="${contractList}" var="contract" varStatus="loopStatus">
            <c:if test="${loopStatus.index == 0}">
                <span class="fs-6" id="span_customer2">고객명&nbsp;|&nbsp;${contract.contractor}</span>
            </c:if>
            </c:forEach>
            </c:if>
            
             <c:if test="${result eq true}">
               <span class="fs-6" id="span_customer">조회결과없음</span>
             </c:if>             
             
        </div>
         <!-- 고객명출력영역 끝 -->

      </div>


      <!-- 계약정보헤더영역 시작 -->
      <div class="row mt-5">
         <div class="col-12">
            <h3>
               <i class="fa-solid fa-stop"></i>&nbsp;계약정보
            </h3>
         </div>
      </div>
      <!-- 계약정보헤더영역 끝 -->


      <!-- 계약정보 본문영역 시작 -->
      <!-- 계약정보 본문(헤더)시작-->
      <div class="row text-center mt-3" id="div_contract_header">
         <div class="col-1">증서번호</div>
         <div class="col-2">상품명</div>
         <div class="col-2">보험료</div>
         <div class="col-2">종납년월</div>
         <div class="col-1">계약상태</div>
         <div class="col-2">계약일자</div>
         <div class="col-1">납입회차</div>
         <div class="col-1">납입방법</div>
      </div>
      <!-- 계약정보 본문(헤더)끝-->


      <!-- 구분선 시작 -->
      <div class="row">
         <div class="col-12">
            <hr>
         </div>
      </div>
      <!-- 구분선 끝 -->



      <!-- 계약정보 본문(내용)시작-->
      <c:forEach items="${contractList}" var="contract">
 
 <div class="row text-center justify-content-center" ondblclick='showAllRows("row_${contract.number }", ${json})' id='row_${contract.number }'>

            <div class="col-1 custom-col" id="here1">${contract.number}</div>
            <div class="col-2 custom-col" id="">${contract.productName}</div>

            <div class="col-2 custom-col" id="">
               <fmt:formatNumber value="${contract.premium}" type="number"
                  pattern="#,###" />
            </div>

            <div class="col-2 custom-col" id="">
               <fmt:formatDate value="${contract.finalDate}" type="date"
                  pattern="yyyy-MM" />
            </div>

            <div class="col-1 custom-col" id="">${contract.status}</div>
            <div class="col-2 custom-col" id="">${contract.date}</div>
            <div class="col-1 custom-col" id="">${contract.count}</div>
            <div class="col-1 custom-col" id="">${contract.paymentMethod}</div>
         </div>
      </c:forEach>
      <!-- 계약정보 본문(내용)끝-->

      <!-- 계약정보 본문영역 끝 -->



      <!-- 즉시출금 헤더 시작 -->
      <div class="row mt-5">
         <div class="col-12">
            <h3>
               <i class="fa-solid fa-stop"></i>&nbsp;즉시출금
            </h3>
         </div>
      </div>
      <!-- 즉시출금 헤더 끝 -->

      <!-- 즉시출금 본문 시작 -->
      <form id="withdrawForm">

         <!-- 즉시출금본문 헤더 시작 -->
         <div class="row text-center mt-3" id="row_withdraw_header">

            <div class="col-2">증서번호</div>
            <div class="col-1">상품명</div>
            <div class="col-1">보험료</div>
            <div class="col-1">종납년월</div>
            <div class="col-1">계약상태</div>
            <div class="col-1">납입회차</div>            
            <div class="col-1">변경납입시작월</div>
            <div class="col-1">변경납입종료월</div>
            <div class="col-1">납입횟수</div>
            <div class="col-2">계좌정보</div>
         </div>
         <!-- 즉시출금본문 헤더 끝 -->

         <!-- 구분선 시작 -->
         <div class="row">
            <div class="col-12">
               <hr>
            </div>
         </div>
         <!-- 구분선 끝 -->


         <!-- 즉시출금본문 클론영역 시작 -->
         <div class="row text-center justify-content-center mb-3 input_row" id="div_row_withdrawl"
            ondblclick="fadeAllRows('row_${contract.number }')">

            <!-- 클론된 div및 값 들어가는 영역 -->

         </div>
         
         <c:forEach items="${accountList}" var="ac" varStatus="status">             
             <input type="hidden" value="${ac.ssn}" id="ssn2" name="ssn">
         </c:forEach>
         <input type="hidden" value="${logInname}" id="name" name="name">
         <input type="hidden" value="${logInusername}" id="username" name="username">
         <input type="hidden" value="${logInteamname}" id="teamname" name="teamname">
         <!-- 즉시출금본문 클론영역 끝 -->

         <!-- 즉시출금 본문 끝 -->


         <!-- 버튼영역 시작 -->
      </form>
      
      <div class="row">
<!-- 취소버튼 시작 -->
         <div class="col-6 text-start">
               
               <button type="button" onclick="clearInputs('row_${contract.number }')"
   class="btn border bg-white text-dark mt-3"
   <c:if test="${empty contractList}">disabled</c:if>
   >취소</button>
               
               
               
         </div>
   <!-- 취소버튼 끝 -->
<!-- 출금버튼 시작 -->
         <div class="col-6 text-end">
            <button type="button" onclick="withdraw()"
               class="btn bg-dark text-white mt-3"
               <c:if test="${empty contractList}">disabled</c:if>
               >출금</button>
               
               
         </div>
<!-- 출금버튼 끝 -->


      </div>

      <!-- 버튼영역 끝 -->

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