	  function selectAll(selectAll)  {
		  const checkboxes 
		       = document.getElementsByName('allPaymentId');
		  
		checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  })
	}
	

// 결재완료
function alertConfirmSubmit() {
   // 스윗알럿을 띄웁니다.
   Swal.fire({
      icon: 'success',
      title: '결재완료!',
      confirmButtonColor: "#373a3c",
      text: '결재가 완료되었습니다.'
   }).then(function(result) {
      if (result.isConfirmed) {
         // 폼을 제출합니다.
         $('#form-confirmDone').submit();
      }
   });

   // 폼 제출을 중지시킵니다.
   return false;
}
	
// 상신취소
function alertCancelSubmit() {
   // 스윗알럿을 띄웁니다.
   Swal.fire({
      icon: 'success',
      title: '상신취소!',
      confirmButtonColor: "#373a3c",
      text: '상신이 취소되었습니다.'
   }).then(function(result) {
      if (result.isConfirmed) {
         // 폼을 제출합니다.
         $('#form-cancleDone').submit();
      }
   });

   // 폼 제출을 중지시킵니다.
   return false;
}


	
	// 반송 결재자 반려
      function updateReject(applyNumber) {
                
         let formData = {               
              applyNumber: $("#applyNumber").val(),               
               username2: $("#username2").val(),
               approver: $("#approver").val()

               };
         console.log(formData);
          
         $.ajax({
            type:"post",
            url:"/refund/updateReject/"+ applyNumber,
            data: formData,
            success: (resp) => {
               let obj = JSON.parse(resp);
          
               if(obj.result === 'success'){
                  Swal.fire({
                     title:obj.message,
                     confirmButtonColor: "#373a3c",
                     icon:'success'
                  }).then(() => {
                     location.href="/refund/confirmAll/";
                    
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