/*핸드폰번호 포맷*/
function formatMobileNumber(mobile) {
	return mobile.replace(/(\d{3})(\d{3})(\d{4})/, "$1-$2-$3");
}


// 페이지 로드가 완료된 후 호출되는 함수
document.addEventListener('DOMContentLoaded', function() {
	// 해당 div 요소의 내용을 가져옴
	const customerMobile = document.getElementById('customer_mobile').textContent;

	// 핸드폰 번호를 포맷팅하여 다시 해당 div 요소의 내용으로 설정
	document.getElementById('customer_mobile').textContent = formatMobileNumber(customerMobile);
});


	
function checkSsn() {
    let modifyPassword = $('#ssn').val();
    let passwordRegex = /^\d+$/;  // 숫자만 입력되었는지 확인

    if (!passwordRegex.test(modifyPassword) || modifyPassword.length !== 13) {
        Swal.fire({
            icon: 'warning',
            title: 'Error',
            text: '13자리 숫자로 입력해주세요!',
            confirmButtonColor: "#373a3c",
            confirmButtonText: '확인'
        });
        return false; // 폼 제출을 막음
    } else {
        console.log("유효합니다.");
        return true; // 폼 제출을 허용
    }
}


function showEmptyResultAlert() {
    Swal.fire({
        title: '조회결과 없음',
        text: '해당 주민번호에 대한 고객정보가 없습니다.',
        icon: 'warning',
        confirmButtonColor: "#373a3c",
        confirmButtonText: '확인'
    });
}

