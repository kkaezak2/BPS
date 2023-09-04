function openForm() {
	document.getElementById("myForm").style.display = "block";
}

function closeForm() {
	document.getElementById("myForm").style.display = "none";
}



// 폼 제출 값 확인용
function onSubmitForm(event) {
	event.preventDefault(); // 폼 제출 동작 중단

	const usernameInput = document.querySelector('input[name="username"]');
	const passwordInput = document.querySelector('input[name="password"]');

	console.log("사번: ", usernameInput.value);
	console.log("비밀번호: ", passwordInput.value);
}


function openForm() {
	document.getElementById("myForm").style.display = "block";
}

function closeForm() {
	document.getElementById("myForm").style.display = "none";
}
//추가
function playSoundAndSubmit() {
	var audioElement = document.getElementById("loginSound");
	audioElement.play();
	setTimeout(function() {
		document.querySelector('.form-container').submit();
	}, 1000); // 3초 후 폼 제출
}
