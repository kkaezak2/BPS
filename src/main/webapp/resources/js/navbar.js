// 비밀번호변경 모달
var modal = document.getElementById('id01');

 	window.onclick = function(event) {
 	  if (event.target == modal) {
 	    modal.style.display = "none";
 	  }
 	}
 	

 	
// 비밀번호변경 유효성검사
function checkPassword(username) {
			
	  	let modifyPassword = $('#modify_password').val();
	  	let passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/;  // 영문,숫자조합 6자리이상
	  	
	  	if (!passwordRegex.test(modifyPassword)) {
	  		
	  		Swal.fire({
		        icon: 'warning',
		        title: '비밀번호 유효성에러!',
		        text: '영문, 숫자조합으로 6자리이상 입력해주세요.',
		        confirmButtonColor: "#373a3c",
		        confirmButtonText: '확인',
		      });
		    } else {
	  	
		let modifyPassword2 = $('#modify_password2').val();

			  if (modifyPassword !== modifyPassword2) {
			     
			      Swal.fire({
			        icon: 'error',
			        title: '비밀번호 불일치!',
			        text: '변경비밀번호가 일치하지 않습니다.',
			        confirmButtonColor: "#373a3c",
			        confirmButtonText: '확인',
			      });
			    } else {
			  
			let formData = {
					username: username,
					password: modifyPassword,
					};
			
			$.ajax({
				type:"post",
				url:"/employee/updatePassword/" + username,
				data: formData,
				success: (resp) => {
					let obj = JSON.parse(resp);
					if(obj.result === 'success'){
						Swal.fire({
							title:obj.message,
							confirmButtonColor: "#373a3c",
							icon:'success'
						}).then(() => {
							location.href="/";
						})
					}else if(obj.result === 'fail'){
						Swal.fire({
							title:obj.message,
							confirmButtonColor: "#373a3c",
							icon:'error'
						});
					}
				}
			});
		}
	}
}

