/*직원등록*/
function startRegistration() {
			let formData = {
					username: $("#username").val(),
					password: $("#register-password").val(),
					name: $("#name").val(),
					teamCode: $("#teamCode").val(),
					teamName: $("#teamName").val()
					};
			/* console.log(formData); */
			
			$.ajax({
				type:"post",
				url:"/employee/validate",
				data: formData,
				success: (resp) => {
					let obj = JSON.parse(resp);
					if(obj.result === 'success'){
						Swal.fire({
							title:obj.message,
							confirmButtonColor: "#373a3c",
							icon:'success'
						}).then(() => {
							location.href="/employee/printAll";
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