  // 계약정보 row 더블클릭시 즉시출금 영역으로 클론,append됨
   function showAllRows(id, jsonData) {
      
      
      let row = $('#' + id); // 더블클릭한 row의 div 요소를 가져옴
      
      /* 클론할 셀값 가져오기 */
       let number = row.find('.custom-col:nth-child(1)').text(); // 증서번호 가져오기
       let productName = row.find('.custom-col:nth-child(2)').text(); // 상품명 가져오기
       let premium = row.find('.custom-col:nth-child(3)').text(); // 보험료 가져오기
       let finalDate = row.find('.custom-col:nth-child(4)').text(); // 종납년월 가져오기
       let status = row.find('.custom-col:nth-child(5)').text(); // 계약상태 가져오기
       let count = row.find('.custom-col:nth-child(7)').text(); // 납입회차 가져오기

       
       /* DIV생성 및 클론된 값, input요소 추가 */
       let numberDiv = $("<div class='col-2 custom-col input_number'>").text(number);
       let productNameDiv = $("<div class='col-1 custom-col input_product_name'>").text(productName);
       let premiumDiv = $("<div class='col-1 custom-col input_premium'>").text(premium);
       let finalDateDiv = $("<div class='col-1 custom-col input_final_date'>").text(finalDate);
       let statusDiv = $("<div class='col-1 custom-col input_status'>").text(status);
       let countDiv = $("<div class='col-1 custom-col input_count'>").text(count);
      
       let startDateDiv = $("<div class='col-1 newInput'>");  // input요소들어갈 div생성
       let endDateDiv = $("<div class='col-1 newInput2'>");  // input요소들어갈 div생성
       let countInputDiv = $("<div class='col-1 newInput3'>");  // input요소들어갈 div생성
       
       let accountSelectDiv = $("<div class='col-2 account'>");  // input요소들어갈 div생성
       
       
       var accountSelectOptions = '<option value="선택하기">계좌선택</option>';

       for (var i = 0; i < jsonData.length; i++) {
           accountSelectOptions += '<option value="' + jsonData[i].bank + '|' + jsonData[i].account + '|' + jsonData[i].depositor + '">' +
                                  jsonData[i].bank + '|' + jsonData[i].account + '|' + jsonData[i].depositor + '</option>';
       }
       
       
       let startDateInput = $("<input id='startDate' placeholder='YYYY-MM' type='text'>");  // 생성된 input DIV안에 input요소 추가
       let endDateInput = $("<input id='endDate' placeholder='YYYY-MM' type='text'>");  // 생성된 input DIV안에 input요소 추가
       let countInput = $("<input id='count' readonly type='text'>");  // 생성된 input DIV안에 input요소 추가
       let accountSelect = $('<select class="form-select text-center" id="accountId">' + accountSelectOptions);
       
       startDateInput.val();  // input요소의 밸류 초기값 없음
       endDateInput.val(); // input요소의 밸류 초기값 없음
       countInput.val();  // input요소의 밸류 초기값 없음

       
       /* 클론될 row내부에 col요소인, 위에서 생성한 div를 추가 */
       $('.input_row').append(numberDiv);
       $('.input_row').append(productNameDiv);
       $('.input_row').append(premiumDiv);
       $('.input_row').append(finalDateDiv);
       $('.input_row').append(statusDiv);
       $('.input_row').append(countDiv);
       
       $('.input_row').append(startDateDiv);
       startDateInput.appendTo(startDateDiv); 
       $('.input_row').append(endDateDiv);
       endDateInput.appendTo(endDateDiv);
       $('.input_row').append(countInputDiv);
       countInput.appendTo(countInputDiv);
       $('.input_row').append(accountSelectDiv);
       accountSelect.appendTo(accountSelectDiv);

       
       $('#' + id).removeAttr('ondblclick');
       
       let clonedRow = $('#' + id).clone();
       $(clonedRow).removeAttr('ondblclick');
       $(clonedRow).attr('id', 'copied_' + id);    

   
   }
   
// 취소버튼 클릭시 클론된 행 비우기
   function clearInputs(id) {
      
      let rows = $('div.col-2.custom-col.input_number');
      
      $.each(rows, (i, n) => {  // i는 인덱스번호, n는 해당인덱스의 요소
         let id = $(n).text();  // n요소의 text를 가져와서 id에 저장
         $('#row_'+id).attr('ondblclick', "showAllRows('row_"+id+"')");
      })
      
   
         let row = $('#' + id); 

         $('.input_number').remove();
          $('.input_product_name').remove();
          $('.input_premium').remove();
          $('.input_final_date').remove();
          $('.input_status').remove();
          $('.input_date').remove();
          $('.input_count').remove();
          $('.input_payment_method').remove();
          
          $('.newInput').remove();
          $('.newInput2').remove();
          $('.newInput3').remove(); 

   }
   
   

   // 월 수 계산 및 count 입력 필드에 표시
   function updateCount() {
       let startDateStr = $('#startDate').val();
       let endDateStr = $('#endDate').val();

       if (startDateStr && endDateStr) {
           let startDate = new Date(startDateStr);
           let endDate = new Date(endDateStr);

           if (startDate <= endDate) {
               let diffMonths = (endDate.getFullYear() - startDate.getFullYear()) * 12;
               diffMonths -= startDate.getMonth();
               diffMonths += endDate.getMonth() + 1;

               if (startDate.getDate() > endDate.getDate()) {
                   diffMonths--;
               }

               $('#count').val(diffMonths);
           } else {
               // 잘못된 날짜 범위를 처리하는 부분
               $('#count').val('잘못된 날짜 범위');
           }
       } else {
           // 날짜 입력이 없는 경우를 처리하는 부분
           $('#count').val('');
       }
   }

   // startDate와 endDate 입력 필드에 이벤트 리스너를 추가합니다.
   $(document).on('change', '#startDate, #endDate', function() {
       updateCount();
   });

   // 초기에 count 값을 계산하고 표시합니다.
   updateCount();


//출금이벤트
 function withdraw(id) {
        
         let row = $('#'+id);

          let selectedAccount = $('#accountId').val();
          let accountParts = selectedAccount.split('|');

          let bank = accountParts[0].trim();
          let account = accountParts[1].trim();
          let depositor = accountParts[2].trim();
         
         let formData = {               
               number: $("#div_row_withdrawl .custom-col:nth-child(1)").text(),
               ssn: $("#ssn2").val(),               
               name: $("#name").val(),
               teamname: $("#teamname").val(),
               username: $("#username").val(),
               startDate: $("#startDate").val(),
               endDate: $("#endDate").val(), 
               bank: bank,
               account: account,
               depositor: depositor
               };
         console.log(formData);
          
         $.ajax({
            type:"post",
            url:"/allpayment/insert",
            data: formData,
            success: (resp) => {
               let obj = JSON.parse(resp);
          
               if(obj.result === 'success'){
                  Swal.fire({
                     title:obj.message,
                     confirmButtonColor: "#373a3c",
                     icon:'success'
                  }).then(() => {
                     location.href="/contract/printAll";
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