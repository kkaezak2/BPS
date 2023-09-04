var checkboxes = Array.from(document.querySelectorAll("input[name='allpaymentId']"));
var lastCheckboxIndex = checkboxes.length - 1;

checkboxes.forEach(function(checkbox, index) {
	checkbox.addEventListener('click', function(event) {
		var currentCheckbox = event.target;

		// 현재 체크박스 클릭 시
		if (currentCheckbox.checked) {
			for (var i = 0; i <= index; i++) {
				checkboxes[i].checked = true;
			}
		}
		// 현재 체크박스 체크 해제 시
		else {
			for (var i = 0; i <= index; i++) {
				checkboxes[i].checked = false;
			}
		}

		// 0번째 인덱스의 체크박스부터 시작하여 활성화
		checkboxes[0].disabled = true;
		for (var i = 0; i <= index; i++) {
			checkboxes[i].disabled = false;
		}
	});
});

// 0번째 인덱스의 체크박스 초기 활성화
checkboxes[0].disabled = false;



function checkAllPaymentId() {
   var allpaymentId = $('#allpaymentId').val();
   //console.log("allpaymentId:" + allpaymentId);

   $.ajax({
      url: '/refund/refundCheck/' + allpaymentId, //Controller에서 요청 받을 주소
      type: 'post', //POST 방식으로 전달
      data: { allpaymentId: allpaymentId },
      success: function(cnt) { //컨트롤러에서 넘어온 cnt값을 받는다 
         if (cnt == 0) { //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
            $('#confirm').modal('show');
         } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
            Swal.fire({
               icon: 'error',
               title: '중복 결재요청!',
               confirmButtonColor: "#373a3c",
               text: '중복된 결재요청건이 있습니다.'
            }).then(function(result) {
               if (result.isConfirmed) {
                  location.href = "/refund/printAll";
               }
            });
         }
      },
   });
};



// 반송결재요청 sweetAlert
function refundAlert() {
   // 스윗알럿을 띄웁니다.
   Swal.fire({
      icon: 'success',
      title: '결재요청 완료!',
      confirmButtonColor: "#373a3c",
      text: '반송 결재요청이 완료되었습니다.'
   }).then(function(result) {
      if (result.isConfirmed) {
         //= 폼을 제출
         $('#form-refund').submit();
      }
   });

   // 폼 제출을 중지
   return false;
} 
