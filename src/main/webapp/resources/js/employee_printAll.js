
/*직원수정 모달*/
var modal = document.getElementById('id01');

window.onclick = function(event) {
	if (event.target == modal) {
		modal.style.display = "none";
	}
}


//직원수정알럿
function ForUpdateEmployee() {
	// 스윗알럿을 띄웁니다.
	Swal.fire({
		icon: 'success',
		title: '직원수정완료!',
		confirmButtonColor: "#373a3c",
		text: '직원정보가 수정되었습니다.'
	}).then(function(result) {
		if (result.isConfirmed) {
			// 폼을 제출합니다.
			$('#alertForUpdateEmployee').submit();

		}
	});
	// 폼 제출을 중지시킵니다.
	return false;
}



/*직원삭제*/
function confirmDelete(username) {
	console.log(typeof (username));
	Swal.fire({ title: '정말로 삭제하시겠습니까?', confirmButtonColor: "#373a3c", showCancelButton: true })
		.then((result) => {
			if (result.isConfirmed) {
				location.href = '/employee/delete/' + username;
			}
		})
}


