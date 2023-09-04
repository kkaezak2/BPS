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
<link rel="stylesheet" type="text/css" href="/resources/css/refund_confirmOne.css">
<!-- js파일 -->
<script src="/resources/js/navbar.js"></script>
<script src="/resources/js/refund_confirmOne.js"></script>

</head>

<body>


	<!-- 네비바 시작 -->
	<jsp:include page="/WEB-INF/views/navbar.jsp" />
	<!-- 네비바 끝 -->

	<div class="mt-5" id="div_body">


		<!-- 납입내역 헤더 시작 -->
		<div class="row mt-5">
			<div class="col-12">
				<h3>
					<i class="fa-solid fa-stop"></i>&nbsp;반송결재
				</h3>
			</div>

		</div>

		<!-- 납입내역 헤더 끝 -->

		  <!-- 납입내역 본문 시작 -->
      <div class="row text-center mt-3" id="div_contractHeader">
     
         <div class="col">신청번호</div>
         <div class="col">증서번호</div>
         <div class="col">고객명</div>
         <div class="col">상품명</div>
         <div class="col">보험료</div>
         <div class="col">납입년월</div>
         <div class="col">납입횟수</div>
         <div class="col">요청자</div>
         <div class="col">결재상태</div>

      </div>

      <!-- 구분선 시작 -->
      <div class="row">
         <div class="col-12">
            <hr>
         </div>
      </div>
      <!-- 구분선 끝 -->
      


<form action="/refund/updateConfirm" method="post" id="form-confirmDone">
<div class="refund-scroll">
         <c:forEach items="${confirmList}" var="confirm">

            <div class="row text-center">
               
               <div class="col custom-col">${confirm.applyNumber}</div>
               <div class="col custom-col">${confirm.number}</div>
               <div class="col custom-col">${confirm.contractor}</div>
               <div class="col custom-col">${confirm.productName}</div>

               <div class="col custom-col">
                  <fmt:formatNumber value="${confirm.premium}" type="number"
                     pattern="#,###" />
               </div>

               <div class="col custom-col">
                  <fmt:formatDate value="${confirm.paidDate}" type="date"
                     pattern="yyyy-MM" />
               </div>
               <div class="col custom-col">${confirm.count}</div>
               <div class="col custom-col">${confirm.name}</div>
               <div class="col custom-col">${confirm.status}</div>

            <input type="hidden" name="applyNumber" id="applyNumber"
               value="${confirm.applyNumber}">
            <input type="hidden" name="allPaymentId" id="allPaymentId"
               value="${confirm.allPaymentId}">
               
            <input type="hidden" name="number" id="number" value="${confirm.number}">   
               
          </div>
         </c:forEach>
         </div>
            <input type="hidden" name="username2" id="username2"
               value="${logInusername}">
             <input type="hidden" name="approver" id="approver"
             value="${logInname}">
         <!-- 납입내역 본문 끝 -->
         
         
    
   
      <div class="row">
      <c:if test="${logIngrade eq '팀장'}">
            <div class="col-12 text-start">
              
               <button type="button" class="btn bg-dark text-white mt-3" id="btn-confirm-done" onclick="alertConfirmSubmit()">결재</button>
               
                <button type="button" onclick="updateReject(${confirm[0].applyNumber})"
                  class="btn bg-dark text-white mt-3">반려</button>   
            </div>
        </c:if>
         </div>
      </form>
    
      
      <c:set var="confirm" value="${confirmList}"/>
  
      <form action="/refund/updateCancel/${confirm[0].applyNumber}" method="post" id="form-cancleDone">
        <c:if test="${logInusername eq confirm[0].username}">
            <div class="col-12 text-start">
               
               <button type="button" class="btn bg-dark text-white mt-3" onclick="alertCancelSubmit()">상신취소</button> 
            </div>
        </c:if>    
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


</body>
</html>