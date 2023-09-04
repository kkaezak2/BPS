
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>



<nav class="row bg-white">
	<div class="col-11">
		<div id="menu">

			<ul class="main1">

				<li id="li_logo" class="header"><a href="/main">
				
				 <b class="fs-3" data-bs-toggle="tooltip" id="mainlogotitle" data-bs-placement="top" title="R U Ok? :)">BPS</b>
				
				 
				</a></li>


				<li class="text-black"><a href="/customer/printOne">고객정보</a></li>
				

				<li id="li_premiumAuto"><a href="#">보험료자동이체</a>
					<ul class="main2">
						<li><a href="/autopayment/printAll">자동이체등록/해지</a></li>
						<li><a href="/autopayment/printOne">변경내역조회</a></li>
					</ul></li>



				<li id="li_premiumPush"><a href="#">보험료납입</a>

					<ul class="main2">
						<li><a href="/contract/printAll">즉시이체</a></li>
						<li><a href="/allpayment/printDetail">즉시이체결과조회</a></li>
						<li><a href="/allpayment/printAll">납입내역조회</a></li>


					</ul></li>

				<li id="li_premiumReject"><a href="#">보험료반송</a>

					<ul class="main2">
						<li><a href="/refund/printAll">반송처리</a></li>
						<li><a href="/refund/confirmAll">반송결재</a></li>
						<li><a href="/refund/confirmDone">결재내역조회</a></li>
					</ul></li>



				<li><a href="/employee/printAll">직원정보</a></li>


				<li><a href="/dashboard/index" class="dashboard-link"><i class="fa-solid fa-chart-simple"> &nbsp;</i>대시보드 </a></li>


				<li id="li_pwdChange" data-bs-placement="top" title="비밀번호변경"><i
					class="fa-solid fa-gear" data-bs-toggle="modal"
					data-bs-target="#${logInusername}"></i></li>

			</ul>



			<!-- 알림창 -->
			<div id="alarmDiv">
				<ul id="alarmUL">
					<!-- 알림메시지 들어가는 공간 -->
				</ul>
			</div>
			<!-- 알림창 끝 -->

		</div>

	</div>



	<div class="col text-end pr-2" id="div_loginname">
		${logInteamname }<br> ${logInname }&nbsp;


		<c:if test="${logInname eq null }">
			<span><a href="">로그인</a></span>&nbsp;
		<i class="fa-regular fa-user"></i>
		</c:if>


		<c:if test="${logInname ne null }">
    <a href="/employee/logout" id="logoutLink"> 
        <i class="fa-solid fa-user" id="i_logout" data-bs-toggle="tooltip" data-bs-placement="top" title="로그아웃"></i>
    </a>
    <!-- MP3 player를 위한 audio 태그 추가 -->
    <audio id="logoutSound" src="/resources/bgm/logout.mp3"></audio>

    
</c:if>
		
		 <input type="hidden" name="username" value="${logInusername}" id="socketuserID">
		

	</div>

</nav>
<script src="/resources/js/alarm.js"></script>
