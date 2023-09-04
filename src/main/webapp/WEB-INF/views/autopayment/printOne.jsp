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
<link rel="stylesheet" type="text/css" href="/resources/css/employee.css">
<link rel="stylesheet" type="text/css" href="/resources/css/navbar.css">
<link rel="stylesheet" type="text/css" href="/resources/css/autopayment_printOne.css">
<!-- js파일 -->
<script src="/resources/js/navbar.js"></script>
<script src="/resources/js/autopayment_printAll.js"></script>
<script src="/resources/js/autopayment_printOne.js"></script>
</head>


<body>

   <!-- 네비바 시작 -->
   <jsp:include page="/WEB-INF/views/navbar.jsp" />
   <!-- 네비바 끝 -->

   <div class="mt-5" id="div_body">
   
      <div class="row justify-content-center" id="">
        
<!-- 사용자 선택 영역 시작 -->



<div class="col-1" id="div_status">
        <input class="form-check-input" type="radio" name="searchType" value="ssn" id="selectedSsn" checked>
    <label class="form-check-label" for="selectedSsn">
        &nbsp;주민등록번호
    </label>
    </div>
    
    
    <div class="col-1" id="div_status2">
        <input class="form-check-input" type="radio" name="searchType" value="number" id="selectedNumber">
        
    <label class="form-check-label" for="selectedNumber">
        &nbsp;증서번호
    </label>

</div>
<!-- 사용자 선택 영역 끝 -->



<!-- 주민등록번호 조회영역 시작 -->
         <div class="col-8 colheader d-flex" id="ssnForm">
   <form class="d-flex" action="/autopayment/printAlldetail" method="post">
      <input class="form-control me-sm-2" type="text" name="ssn" id="ssn" value=""
         placeholder="주민등록번호" minlength="13" maxlength="13" required>
         
      <input class="form-control me-sm-2" type="date" name="startDate" id="startDate">
      
      <input class="form-control me-sm-2" type="date" name="endDate" id="endDate">
      
      <button class="btn bg-dark text-white ml-2 mr-4" type="submit">조회</button>
      
   </form>
</div>

         <!-- 주민등록번호 조회영역 끝 -->


         <!-- 증서번호 조회영역 시작 -->
         <div class="col-8 colheader d-flex" id="numberForm">
   <form class="d-flex" action="/autopayment/printOnedetail" method="post">
      <input class="form-control me-sm-2" name="number" value="" id="contract_number"  placeholder="증서번호" minlength="10" maxlength="10" required>
      <input class="form-control me-sm-2" type="date" name="startDate" id="startDate">
      <input class="form-control me-sm-2" type="date" name="endDate" id="endDate">
      <button class="btn bg-dark text-white ml-2 mr-4" type="submit">조회</button>
   </form>
</div>
         <!-- 증서번호 조회영역 끝 -->



         <!-- 고객명출력 시작 -->
          <div class="col-2 colheader d-flex" id="div_customerReport">         
         
         <c:set value="${emptyResult}" var="result" />
             <c:if test="${result eq false}">
              <c:forEach items="${contractList}" var="contract" varStatus="loopStatus">
            <c:if test="${loopStatus.index == 0}">
                <span class="fs-6 customer_name" id="customer_name">고객명&nbsp;|&nbsp;${contract.contractor}</span>
            </c:if>
            </c:forEach>
            </c:if>
            
             <c:if test="${result eq true}">
               <span class="fs-6 customer_name" id="customer_name">조회결과없음</span>
             </c:if>             
             
        </div>
         <!-- 고객명출력 끝 -->
</div>






         <!-- 헤더 시작 -->
         <div class="row mt-5">
            <div class="col-11">
               <h3>
                  <i class="fa-solid fa-stop"></i>&nbsp;변경내역조회
               </h3>
            </div>
         <!-- 헤더 끝 -->
         
       
       <!-- 버튼명:메일 전송 시작 -->
      <div class="col-1 text-center">
      
    
      <button type="button" id="mailBtnCustom" class="btn bg-dark text-white" data-bs-toggle="modal" data-bs-target="#sendTocustomer" title="메일발송">
	<i class="fa-solid fa-envelope" id="icon_mailtocustomer"></i></button>
      
      
      <!-- 고객메일발송 시작 -->

				<div class="modal" id="sendTocustomer">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title"><i class="fa-solid fa-square"></i>&nbsp;자동이체&nbsp;변경내역발송
								</h5>
			
			</div>
			
			<form action="sendEmail" method="post" id="form-sendMail">
			
				<div class="modal-body">
				
					<div class="row mb-3">
						<label for="title" class="col-sm-3 col-form-label text-center">주민등록번호</label>
						<div class="col-9">
                            <input type="text" id="ssnNumber" name="ssn" placeholder="주민번호를 입력하세요" class="form-control" maxlength="13" required/>
						</div>
					</div>


					<div class="row mb-3">
						<label for="title" class="col-sm-3 col-form-label text-center">이메일</label>
						<div class="col-9">
						<input type="email" id="emailAddress" name="emailAddress" placeholder="이메일주소를 입력하세요" class="form-control" required/>
						</div>
					</div>


				</div>
				<div class="modal-footer">
					
					<button type="button" class="btn bg-dark text-white" onclick="sendMailCustomer()">전송</button>
					<button type="button" class="btn bg-white text-dark"
						data-bs-dismiss="modal">취소</button>
				</div>
			</form>
		</div>
	</div>
</div>
				<!-- 고객메일발송 끝 -->
      
      
      </div>

       <!-- 버튼명:메일 전송 끝 -->
       
         </div>
       
       


         <!-- 본문 시작 -->
         
         <!-- 본문(헤더)시작 -->
         <div class="row text-center mt-3 content_header">
            <div class="col-1">증서번호</div>
            <div class="col-1">상품명</div>
            <div class="col-1">보험료</div>
            <div class="col-1">계약상태</div>
            <div class="col-1">납입방법</div>
            <div class="col-1">자동이체일자</div>
            <div class="col-1">은행명</div>
            <div class="col-1">계좌번호</div>
            <div class="col-1">예금주</div>
            <div class="col-1">구분</div>
            <div class="col-2">변경일자</div>
         </div>
<!-- 본문(헤더) 끝 -->

              <!-- 구분선 시작 -->
		<div class="row">
			<div class="col-12">
				<hr>
			</div>
		</div>
		<!-- 구분선 끝 -->
		
         
         
         
        <!-- 본문(내용) 시작 -->
        <div class="combined-scroll">
                <c:forEach items="${combinedList}" var="combined">
            
 <div class="row border-bottom text-center justify-content-center" ondblclick='showAllRows("row_${combined.number}", ${json})' id='row_${combined.number }' >
                     
                     
                     <div class="col-1 custom-col">${combined.number}</div>
                     <div class="col-1 custom-col">${combined.productName}</div>
                     <div class="col-1 custom-col">
                        <fmt:formatNumber value="${combined.premium}" type="number"
                           pattern="#,###" />
                     </div>
                     <div class="col-1 custom-col">${combined.status}</div>
                     <div class="col-1 custom-col">${combined.paymentMethod}</div>
                     <div class="col-1 custom-col">${combined.accountDate}</div>
                     <div class="col-1 custom-col">${combined.bank}</div>
                     <div class="col-1 custom-col">
                        <c:choose>
                           <c:when test="${combined.account == 0}"></c:when>
                           <c:otherwise>${combined.account}</c:otherwise>
                        </c:choose>
                </div>
                     <div class="col-1 custom-col">${combined.depositor}</div>
                     <div class="col-1 custom-col">${combined.accountOption}</div>
                     <div class="col-2 custom-col">
                        <fmt:formatDate value="${combined.modifyDate}" pattern="yyyy-MM-dd  HH:mm" />
                     </div>
                  </div>
            
            </c:forEach>
         </div>
         <!-- 본문(내용) 끝 --> 
         
         </div>
         
         
         
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
         
         
         <!-- </div> -->
         
           
</body>
</html>