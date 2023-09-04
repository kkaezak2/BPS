// 페이지 진입시
window.onload = function() {
	// 챗봇실행
	const chatPopup = document.getElementById("chatPopup");
	chatPopup.style.display = "block";


	// 에디터실행
	ClassicEditor
		.create(document.querySelector('#content'))
		.catch(error => {
			console.error(error);
		});


	// 스낵바	
	var x = document.getElementById("snackbar");

	x.className = "show";

	setTimeout(function() { x.className = x.className.replace("show", ""); }, 3000);
};



// 챗봇
Kakao.init('33**************1136**********67'); // 사용하려는 앱의 JavaScript 키 입력

function chatChannel() {
	Kakao.Channel.chat({
		channelPublicId: '_Pdmxoxj',
	});
}


// 일정등록
function addSchedule(logInusername, title, start, end) {

	let addusername = logInusername,
		addtitle = title,
		addstart = start,
		addend = end;

	let formData = {
		writerId: addusername,
		title: addtitle,
		start: addstart,
		end: addend
	};

	$.ajax({
		type: "post",
		url: "/validate",
		data: formData,
		success: (resp) => {
			let obj = JSON.parse(resp);
			if (obj.result === 'success') {
				Swal.fire({
					title: obj.message,
					confirmButtonColor: "#373a3c",
					focusConfirm: false,
					icon: 'success'
				}).then(() => {
					location.href = "/main";
				})
			} else if (obj.result === 'fail') {
				Swal.fire({
					title: obj.message,
					confirmButtonColor: "#373a3c",
					icon: 'error'
				});
			}
		}
	});
}

// 달력(일정)뷰
document.addEventListener('DOMContentLoaded', function() {

	let calendarEl = document.getElementById('calendar');

	let calendar = new FullCalendar.Calendar(calendarEl, {
		height: 600,

		firstDay: 1,
		timeZone: 'local',
		buttonText: {
			today: '오늘'
		},

		titleFormat: function(date) {
			year = date.date.year;
			month = date.date.month + 1;
			return year + "년 " + month + "월";
		},

		customButtons: {
			customBtn: {
				text: '일정등록',
				confirmButtonColor: "#373a3c",
				click: function() {
					openModal(); // 모달 열기 함수 호출
				}
			}
		},

		headerToolbar: {
			left: 'prev customBtn',
			center: 'title',
			right: 'today next'
		},

		initialView: 'dayGridMonth',

		events: '/getEvents', // 서버에서 일정 데이터를 가져올 엔드포인트 경로
		
		eventClick: function(info) {

			let eventId = info.event.id;

			Swal.fire({
				title: '일정을 삭제하시겠습니까?',
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: "#373a3c",
				confirmButtonText: '예',
				cancelButtonText: '아니오'

			}).then((result) => {
				if (result.isConfirmed) {
					deleteEvent(eventId);
					console.log("알럿eventId: " + eventId);
				}
			});
		}

	});
	calendar.render();
});






// 일정등록 모달 열기
function openModal() {
	let modal = document.getElementById('addSchedule');
	modal.style.display = 'block';
}

// 일정등록 모달 닫기
function closeModal() {
	let modal = document.getElementById('addSchedule');
	modal.style.display = 'none';
}

// 일정삭제 
function deleteEvent(eventId) {
	$.ajax({
		type: "post",
		url: "/deleteEvents/" + eventId,
		data: { id: eventId },
		dataType: "json",
		success: (resp) => {
			let obj = resp; // resp가 이미 파싱된 JSON 데이터
			if (obj.result === 'success') {
				Swal.fire({
					title: obj.message,
					confirmButtonColor: "#373a3c",
					icon: 'success'
				}).then(() => {
					location.href = "/main";
					var calendar = $('#calendar').fullCalendar('getCalendar');
					calendar.refetchEvents();

				});
			} else if (obj.result === 'fail') {
				Swal.fire({
					title: obj.message,
					confirmButtonColor: "#373a3c",
					icon: 'error'
				});
			}
		},
		error: function(xhr) {
			// 삭제 실패 시 에러 처리
			alert("일정 삭제에 실패했습니다!");
		}
	});
}



// 공지사항보기_모달
var modal = document.getElementById('id01');

window.onclick = function(event) {
	if (event.target == modal) {
		modal.style.display = "none";
	}
}


//공지사항등록(수정)
function addNotice() {
   // 스윗알럿을 띄웁니다.
   Swal.fire({
      icon: 'success',
      title: '공지사항 등록완료!',
      confirmButtonColor: "#373a3c",
      text: '공지사항 등록이 완료되었습니다.'
   }).then(function(result) {
      if (result.isConfirmed) {
         //= 폼을 제출
         $('#form-file').submit();
      }
   });

   // 폼 제출을 중지
   return false;
}


// 공지사항수정용 textarea
function initCKEditorForUpdate(noticeId) {
	// Open the modal by its ID
	const updateModal = document.getElementById(`updateModal(${noticeId})`);
	const contentTextarea = updateModal.querySelector('#update_content');

	ClassicEditor
		.create(contentTextarea)
		.catch(error => {
			console.error(error);
		});

	// Trigger the modal to be shown
	const modal = new bootstrap.Modal(updateModal);
	modal.show();
}



// 공지사항 삭제
function noticeDelete(id) {
	Swal.fire({
		title: '정말로 삭제하시겠습니까?', showCancelButton: true, confirmButtonText: '예', confirmButtonColor: "#373a3c",
		cancelButtonText: '아니오'
	})
		.then((result) => {
			if (result.isConfirmed) {
				location.href = '/deleteNotice/' + id;
			}
		})
}



function myFunction() {
	// Get the snackbar DIV
	var x = document.getElementById("snackbar");

	// Add the "show" class to DIV
	x.className = "show";

	// After 3 seconds, remove the show class from DIV
	setTimeout(function() { x.className = x.className.replace("show", ""); }, 3000);
}
