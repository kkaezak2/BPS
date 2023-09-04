<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<link rel="stylesheet" type="text/css" href="/resources/css/customer_printOne.css">
<!-- js파일 -->
<script src="/resources/js/navbar.js"></script>
<script src="/resources/js/customer_printOne.js"></script>

</head>


<body>
	
	<!-- 네비바 시작 -->
	<jsp:include page="/WEB-INF/views/navbar.jsp" />
	<!-- 네비바 끝 -->

	<div class="mt-5" id="div_body">
	
	
	<!-- 상단 조회영역 시작 -->
		<div class="row text-center justify-content-center">
		
		
		  <!-- 주민등록번호 조회영역 시작 -->
         <div class="col-12 colheader d-flex">


        <form class="d-flex" action="/customer/printOne" method="post" id="searchForm">
        
    <input class="form-control me-sm-2" name="ssn" id="ssn" value="" placeholder="주민등록번호" minlength="13" maxlength="13" required>
    <button class="btn bg-dark text-white ml-2 mr-4" type="submit">조회</button>
</form>
     </div>
         <!-- 주민등록번호 조회영역 끝 -->
		
		</div>
	<!-- 상단 조회영역 끝 -->
		
		
		
<!-- 고객정보 1줄 출력시작 -->
		
		<!-- 처음 화면진입 시작 -->
		<c:if test="${empty customerList}">
				<div class="row mt-3" id="div_customer_report">
			<div class="col-1 text-center p-3" id="col_customer">고객명</div>
			<div class="col-1 text-start border p-3" id="col_customer2"></div>
			<div class="col-1 text-center p-3" id="col_addr">주소</div>
			<div class="col-3 text-start border p-3" id="col_addr2"></div>
			<div class="col-1 text-center p-3" id="col_tel">핸드폰</div>
			<div class="col-2 text-start border p-3"></div>
			
		</div>
		
		</c:if>
		<!-- 처음 화면진입 끝 -->
		
		
		
		<!-- 주민번호 조회되는경우 시작 -->
         <div class="row mt-3" id="div_customer_report2">
          <c:set value="${emptyResult}" var="result" />
         
          <c:forEach items="${customerList}" var="customer">
          
         <c:if test="${result eq false}">
         
         <div class="col-1 text-center p-3" id="col_customer_3">고객명</div>
         <div class="col-1 text-start border p-3" id="col_customer_32">${customer.name }</div>
         <div class="col-1 text-center p-3" id="col_addr_3">주소</div>
         <div class="col-3 text-start border p-3" id="col_addr_32">${customer.addr1 }&#44;&nbsp;${customer.addr2 }</div>
         <div class="col-1 text-center p-3" id="col_tel3">핸드폰</div>
         <div class="col-2 text-start border p-3" id="customer_mobile">${customer.mobile }</div>
         </c:if>
         
         </c:forEach>
   
         <c:if test="${result eq true}">
         
        <script>
                 showEmptyResultAlert()
              </script>
          </c:if>   
         
      </div>
      <!-- 주민번호 조회되는경우 끝 -->   
		
		
		
<!-- 고객정보 1줄 출력끝 -->
		

		<!-- 계약정보 출력시작 -->
		
		<div class="row mt-5">
		
		</div>
		
			<div class="col-12">
				<h3>
					<i class="fa-solid fa-stop"></i>&nbsp;계약정보
				</h3>
			</div>
	

		<div class="row text-center mt-3" id="div_contract_header">
			<div class="col-1">증서번호</div>
			<div class="col-2">상품명</div>
			<div class="col-1">보험료</div>
			<div class="col-2">계약일자</div>
			<div class="col-1">계약상태</div>
			<div class="col-2">종납년월</div>
			<div class="col-1">납입회차</div>
			<div class="col-2">납입방법</div>
		</div>
		
		
		<div class="row">
		<div class="col-12">
		<hr>
		</div>
		
		</div>
		
		
		<div class="row text-center justify-content-center">		
			<c:forEach items="${contractList}" var="contract">
			
				<div class="col-1 custom-col">${contract.number}</div>
				<div class="col-2 custom-col">${contract.productName}</div>
				<div class="col-1 custom-col">
				<fmt:formatNumber value="${contract.premium}" type="number" pattern="#,###" />
				</div>
				
				<div class="col-2 custom-col">${contract.date}</div>
				<div class="col-1 custom-col">${contract.status}</div>
				
				<div class="col-2 custom-col">
				<fmt:formatDate value="${contract.finalDate}" type="date" pattern="yyyy-MM" />
				</div>
				
				<div class="col-1 custom-col">${contract.count}</div>
				<div class="col-2 custom-col">${contract.paymentMethod}</div>
			</c:forEach>	
		</div>

<!-- 계약정보 출력끝 -->
<div class="row" id="btn-direct-to">

</div>

<!-- 바로가기 버튼 시작 -->
 <div class="row position-relative" id="btn-direct-from">
<c:if test="${empty customerList }">
  <div class="col-auto ms-auto">
 <button type="submit" class="btn bg-dark text-white mt-3" disabled>자동이체&nbsp;변경</button>
 </div>
  <div class="col-auto"><button type="submit" class="btn bg-dark text-white mt-3" disabled>즉시이체&nbsp;신청</button>
</div>
</c:if>

<c:forEach items="${customerList}" var="customer">
          <!--   <div class="row position-relative" id="btn-direct-from"> -->
               <div class="col-auto ms-auto">

                  <form action="/autopayment/printAll" method="post">
                     <input type="hidden" value="${customer.ssn}" name="ssn">
                     <button type="submit" class="btn bg-dark text-white mt-3">자동이체&nbsp;변경</button>
                  </form>
               </div>
               <div class="col-auto">
                  <form action="/contract/printAll" method="post">
                     <input type="hidden" value="${customer.ssn}" name="ssn">
                     <button type="submit" class="btn bg-dark text-white mt-3">즉시이체&nbsp;신청</button>
                  </form>
               </div>
</c:forEach>
            </div>
            <!-- 바로가기 버튼 끝 -->


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