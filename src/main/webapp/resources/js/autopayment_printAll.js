// 계좌신규등록
      function bankRegistration() {
		  
		 let selectedBank = $("input[name='bank']:checked").val();
		  
         let formData = {
               bank: selectedBank,
               account: $("#account").val(),
               depositor: $("#depositor").val(),
               depositorSsn: $("#depositorSsn").val(),
               ssn: $("#ssn1").val()
            
               };
         
         $.ajax({
            type:"post",
            url:"/account/register",
            data: formData,
            success: (resp) => {
               let obj = JSON.parse(resp);
               if(obj.result === 'success'){
                  Swal.fire({
                     title:obj.message,
                     confirmButtonColor: "#373a3c",
                     icon:'success'
                  }).then(() => {
                     location.href="/autopayment/printAll";
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

     
      
 $(document).on('change', 'select[id$="_paymentMethod"]', function() {
  var row = $(this).closest('.row');
  if ($(this).val() === '방문수금') {
    // 방문수금이 선택되면 다른 옵션들을 비활성화
    row.find('select[id$="_accountDate"]').prop('disabled', true).val('선택하기');
    row.find('select[id$="_account"]').prop('disabled', true).val('선택하기');
  } else {
    // 방문수금 이외의 것이 선택되면 다른 옵션들을 활성화
    row.find('select[id$="_accountDate"]').prop('disabled', false);
    row.find('select[id$="_account"]').prop('disabled', false);
  }
});

// 더블클릭순간 복제되는 구간
function showAllRows(id, jsonData) {
	 console.log("id: "+id);

	   for (var i = 0; i < jsonData.length; i++) {
	        console.log("Item " + i + ":");
	        console.log("Bank: " + jsonData[i].bank);
	        console.log("Account: " + jsonData[i].account);
	        console.log("Depositor: " + jsonData[i].depositor);
	    }
	 
	 
    var originalRow = $('#' + id);

       if (originalRow.hasClass('cloned')) {
           console.log("Row already cloned");
           return;
       }

       var clonedRow = originalRow.clone();
       clonedRow.children('div:gt(3)').remove();  // 4번째부터~ 요소의값은 제거
       originalRow.addClass('cloned');
       clonedRow.removeClass('cloned');
       clonedRow.unbind();

       // 새로운 고유 ID 생성
       var uniqueId = id + '_clone_' + Date.now();
       clonedRow.attr('id', uniqueId); // 클론된 row에 새로운 ID 할당

       clonedRow.find("#paymentMethod").attr("id", uniqueId + "_paymentMethod");
       clonedRow.find("#accountDate").attr("id", uniqueId + "_accountDate");
       clonedRow.find("#accountId").attr("id", uniqueId + "_account");

       clonedRow.append('<div class="col-2 custom-col"><form class="form-control customform" style="border:none;"><select class="form-select text-center" id="' + uniqueId + '_paymentMethod" name="paymentMethod">' +
           '<option value="선택하기">업무구분</option>' +
           '<option value="자동이체">자동이체등록</option>' +
           '<option value="방문수금">자동이체해지</option>' +
           '</select></form></div>');

       clonedRow.append('<div class="col-2 custom-col"><form class="form-control customform" style="border:none;"><select class="form-select text-center" id="' + uniqueId + '_accountDate" name="accountDate">' +
           '<option value="선택하기">이체일자선택</option>' +
           '<option value="5">5일</option>' +
           '<option value="10">10일</option>' +
           '<option value="15">15일</option>' +
           '<option value="20">20일</option>' +
           '<option value="25">25일</option>' +
           '</select></form></div>');


    var accountSelectOptions = '<option value="선택하기">계좌선택</option>';

    for (var i = 0; i < jsonData.length; i++) {
        accountSelectOptions += '<option value="' + jsonData[i].bank + '|' + jsonData[i].account + '|' + jsonData[i].depositor + '">' +
                               jsonData[i].bank + '|' + jsonData[i].account + '|' + jsonData[i].depositor + '</option>';
    }

    
    
     clonedRow.append('<div class="col-2 custom-col"><label for="' + uniqueId + '_account" class="form-label" style="margin:auto;">' +
               '<select class="form-select text-center" id="' + uniqueId + '_account">' + accountSelectOptions + '</select></label></div>'); // 고유한 ID가 있는 계좌 선택 요소 추가

       $('#div_row_autopayment').append(clonedRow);
   } 




  // 변경처리 이벤트
function autopayment() {
    var formDataArray = [];
    var validationPassed = true; // 모든 행의 유효성 검사를 통과했는지 확인하는 변수(추가)
    
    $("#div_row_autopayment .row").each(function() {
        var row = $(this);
        var rowId = row.attr('id');
        
        var paymentMethod = row.find("#" + rowId + "_paymentMethod").val();
        var accountDate = row.find("#" + rowId + "_accountDate").val();
        var accountInfo = row.find("#" + rowId + "_account").val();
        var bank = null;
        var account = null;
        var depositor = null;
        
        // 선택하기 옵션을 체크(추가)
        
      if (paymentMethod === "선택하기" 
       || (paymentMethod !== "방문수금" && accountDate === "선택하기")
       || (paymentMethod !== "방문수금" && accountInfo === "선택하기")) {         
            Swal.fire({
              title: '올바른 값을 선택해주세요.',
              confirmButtonColor: "#373a3c",
              icon: 'warning'
            });
            validationPassed = false; // 유효성 검사 실패를 표시
            return false; // each 반복문 종료
        }
        
        
        
        if (accountInfo) {
            var parts = accountInfo.split('|');
            if (parts.length === 3) {
                bank = parts[0];
                account = parts[1];
                depositor = parts[2];
            }
        }

        // "자동이체해지" 선택 시 데이터를 "0"으로 설정
        if (paymentMethod === '방문수금') {
            accountDate = '해지';
            bank = null;
            account = 0;
            depositor = null;
        } else if (paymentMethod !== '자동이체') { // 자동이체등록이 아닌 다른 옵션을 선택한 경우 계좌 정보를 무시
            bank = null;
            account = null;
            depositor = null;
        }
        
        // 해당 row에 대한 formData 객체를 생성합니다.
        let formData = {
            number: row.find(".custom-col:nth-child(1)").text(),
            paymentMethod: paymentMethod,
            accountDate: accountDate,
            bank: bank,
            account: account,
            depositor: depositor
        };

        // ArrayList에 추가합니다.
        formDataArray.push(formData);
    });
    
        // formDataArray가 비어있으면 함수를 종료(추가)
       if (!formDataArray.length) return;
        // 유효성 검사를 통과하지 못했으면 함수 종료(추가)
       if (!validationPassed) return;


  console.log("Form Data Array:", formDataArray);

  // ArrayList를 서버에 전송합니다.
  $.ajax({
    type: "post",
    url: "/autopayment/insert",
    data: JSON.stringify(formDataArray),
    contentType: 'application/json', // JSON 형식으로 전송
    success: (resp) => {
      let obj = JSON.parse(resp);
      if (obj.result === 'success') {
        Swal.fire({
          title: obj.message,
          confirmButtonColor: "#373a3c",
          icon: 'success'
        }).then(() => {
          location.href = "/autopayment/printAll";
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



     