const alarmUL = document.querySelector("#alarmUL");
//const alarmI = document.querySelector("#alarmI");
const alarmDiv = document.querySelector("#alarmDiv");
var ws = null;


//소켓
window.addEventListener('load', function connectWs() {
	let applyNumArray = [];
	ws = new WebSocket('ws://localhost/ws-alarm');
	/*ws = new WebSocket('ws://3.37.246.37:8080/ws-alarm');*/

	ws.onopen = function(event) {
		console.log("ws.open", event);
		console.log("연결완료");
		ws.send($('#socketuserID').val());
	};


	function handleAlarm(event) {
		console.log("ws.onmessage", event);

		let newAlarmData = JSON.parse(event.data);
		let senderId = newAlarmData.senderId;
		let receiverId = newAlarmData.receiverId;
		let username = newAlarmData.username;
		let socketuserID = $('#socketuserID').val();

		console.log("senderId", senderId);
		console.log("receiverId", receiverId);
		console.log("username", username);

		if (receiverId == socketuserID) {

			let newAlarm = '';
			newAlarm += '<li class="border-dark mt-2 mb-1" id="alarmLi" value=' + newAlarmData.applyNum + ' scope="col">' + newAlarmData.message + "</li>";

			$('#alarmUL').append(newAlarm);
			alarmDiv.style.visibility = "visible";
			applyNumArray.push(newAlarmData.applyNum);
		}
	}
	ws.onmessage = handleAlarm;

	// 여기까지


	ws.onclose = function(event) {
		console.log("ws.onclose", event);
		console.log('close');
	};

	// 기존 코드  
	alarmUL.addEventListener('click', function(e) {

		var endIdx = e.target.textContent.indexOf(")");
		var idx = e.target.textContent.substr(1, endIdx - 1);
		console.log(endIdx);
		let applyNumber = e.target.value;
		console.log(applyNumber);

		$.ajax({
			url: '/refund/updateAlarm/' + applyNumber,
			data: { "applyNumber": applyNumber },
			type: 'post',
			success: function(data) {
				console.log("data:" + data);
				//alert("성공");
			}
		})

		$(e.target).remove();
		if (alarmUL.children.length == 0) {
			alarmDiv.style.visibility = "hidden";
		}
	});
})



// 로그아웃 클릭 이벤트 추가
   document.getElementById('logoutLink').addEventListener('click', function(event){
       // 로그아웃 액션 일시 중지
       event.preventDefault();
   
       // MP3 파일 재생
       var audio = document.getElementById('logoutSound');
       audio.play();
   
       // 3초 후에 로그아웃 액션 실행
       setTimeout(function(){
           window.location.href = "/employee/logout";
       }, 3000); 
   });
