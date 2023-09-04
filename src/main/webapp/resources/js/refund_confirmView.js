function selectAll(selectAll) {
	const checkboxes
		= document.getElementsByName('allPaymentId');

	checkboxes.forEach((checkbox) => {
		checkbox.checked = selectAll.checked;
	})
}


document.getElementById("find_number").addEventListener("input",
	function() {
		const ssn = this.value.replace(/[^0-9]/g, ""); // 입력된 값에서 숫자만 추출

		if (ssn.length !== 10) {
			this.setCustomValidity("증서번호는 10자리 숫자로 입력해주세요!");
		} else {
			this.setCustomValidity(""); // 유효성 검증 메시지 삭제
		}
	});