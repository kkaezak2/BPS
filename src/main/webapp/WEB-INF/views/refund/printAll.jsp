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
<link rel="stylesheet" type="text/css" href="/resources/css/refund_printAll.css">

<!-- js파일 -->
<script src="/resources/js/navbar.js"></script>
</head>


<body>

<!-- 네비바 시작 -->
   <jsp:include page="/WEB-INF/views/navbar.jsp" />
   <!-- 네비바 끝 -->

   <div class="mt-5" id="div_body">

      <div class="row justify-content-center">

         <!-- 증서번호 조회영역 시작 -->
         <div class="col-10 colheader d-flex">
            <form class="d-flex" action="/refund/printAll" method="post">
               <input class="form-control me-sm-2" name="number" id="find_number"
                  value="" placeholder="증서번호" minlength="10"
                  maxlength="10" required>

               <button class="btn bg-dark text-white ml-2 mr-4" type="submit">조회</button>
            </form>
         </div>

         <!-- 증서번호 조회영역 끝 -->
         
         
         
           <!-- 고객명출력영역 시작 -->
    
       <div class="col-2 colheader d-flex" id="col_customer_report">         
         
         <c:set value="${emptyResult}" var="result" />
            
             <c:if test="${result eq true}">
               <span class="fs-6" id="span_customer">조회결과없음</span>
             </c:if>             
             
        </div>
       
         <!-- 고객명출력영역 끝 -->
         
         
         

      </div>

      <!-- 납입내역 헤더 시작 -->
      <div class="row mt-5">
         <div class="col-12">
            <h3>
               <i class="fa-solid fa-stop"></i>&nbsp;반송처리
            </h3>
         </div>

      </div>

      <!-- 납입내역 헤더 끝 -->

      <!-- 납입내역 본문 시작 -->
      <div class="row text-center mt-3" id="div_contractHeader">
         <div class="col-1">선택</div>
         <div class="col-1">증서번호</div>
         <div class="col-2">고객명</div>
         <div class="col-2">상품명</div>
         <div class="col-1">보험료</div>
         <div class="col-1">계약상태</div>
         <div class="col-1">납입방법</div>
         <div class="col-1">납입상태</div>
         <div class="col-1">납입년월</div>
         <div class="col-1">납입횟수</div>

      </div>

      <!-- 구분선 시작 -->
      <div class="row">
         <div class="col-12">
            <hr>
         </div>
      </div>
      <!-- 구분선 끝 -->
      <form action="/refund/insert" method="post" id="form-refund" >
 <div class="refund-scroll">
         <c:forEach items="${allPaymentList}" var="allpayment"
            varStatus="status">


            <div class="row text-center justify-content-center">
               <div class="col-1 custom-col">
                  <input class="form-check-input border-dark" type="checkbox"
                     value="${allpayment.id}" name="allpaymentId" id="allpaymentId">
               </div>


               <div class="col-1 custom-col">${allpayment.number}</div>
               <div class="col-2 custom-col">${allpayment.contractor}</div>
               <div class="col-2 custom-col">${allpayment.productName}</div>

               <div class="col-1 custom-col">
                  <fmt:formatNumber value="${allpayment.premium}" type="number"
                     pattern="#,###" />
               </div>

               <div class="col-1 custom-col">${allpayment.status}</div>
               <div class="col-1 custom-col">${allpayment.paymentMethod}</div>
               <div class="col-1 custom-col">${allpayment.paymentStatus}</div>

               <div class="col-1 custom-col">
                  <fmt:formatDate value="${allpayment.paidDate}" type="date"
                     pattern="yyyy-MM" />

               </div>

               <div class="col-1 custom-col">${allpayment.count}</div>

            </div>
         </c:forEach>
            
            </div>
            
         <!-- 납입내역 본문 끝 -->
         

<div class="row">

            <div class="col-12 text-start">
                  
                   <button type="button" id="confirmbtn" onclick="checkAllPaymentId()"
                   class="btn bg-dark text-white mt-3"
                  <c:if test="${empty allPaymentList}">disabled</c:if>
                  >결재요청</button>
                  
            </div>
            <div class="modal" id="confirm">
               <div class="modal-dialog modal-dialog-centered" role="document">
                  <div class="modal-content">
                     <div class="modal-header">
                     
                     <h5 class="modal-title">
										<i class="fa-solid fa-square"></i>&nbsp;결재상신
									</h5>
               
                    
                     </div>

                     <div class="modal-body">
                        <label class="form-label" id="label_approverForm">결재자
                        </label> 
                        <c:forEach var="approver" items="${employeeList}">
                        <c:if test="${approver.teamName eq logInteamname}">
                        <input type="text" class="form-control" name="approver" id="input_approver"
                           value="${approver.name}" readonly>
                            <input type="hidden" name="receiver" id="receiver" value="${approver.username}">   
                           
                  
                           </c:if>
                     </c:forEach>
                     </div>
                     <div class="modal-footer">
                        <button type="button" class="btn bg-dark text-white" onclick="refundAlert();connectWs();">상신</button>
                        <button type="button" class="btn bg-white text-dark"
                           data-bs-dismiss="modal">취소</button>
                     </div>

                  </div>
               </div>
            </div>
            
            <input type="hidden" name="username" value="${logInusername}">
            <input type="hidden" name="name" value="${logInname}"> 
            <input type="hidden" name="teamName" value="${logInteamname}">
         </div>
      </form>
      
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


<!-- js파일 -->
<script src="/resources/js/refund_printAll.js"></script>


</body>
</html>