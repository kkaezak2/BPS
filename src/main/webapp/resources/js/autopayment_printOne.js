
// 메일발송
function sendMailCustomer() {
   // 스윗알럿을 띄웁니다.
   Swal.fire({
      icon: 'success',
      title: '메일발송완료!',
      confirmButtonColor: "#373a3c",
      confirmButtonText:'확인',
   }).then(function(result) {
      if (result.isConfirmed) {
         // 폼을 제출합니다.
         $('#form-sendMail').submit();
      }
   });

   // 폼 제출을 중지시킵니다.
   return false;
}



//라디오버튼
document.addEventListener('DOMContentLoaded', function() {
    // 페이지 로딩 시 기본 설정
    document.getElementById('ssnForm').style.cssText = 'display: flex !important;';
    document.getElementById('numberForm').style.cssText = 'display: none !important;';

    let radioButtons = document.querySelectorAll('input[name="searchType"]');

    for (let radio of radioButtons) {
        radio.addEventListener('change', function() {
            console.log("Selected value:", radio.value);  // 선택된 라디오 버튼의 값을 출력

            if (radio.value === 'ssn') {
                console.log("Showing ssnForm, hiding numberForm");
                document.getElementById('ssnForm').style.cssText = 'display: flex !important;';
                document.getElementById('numberForm').style.cssText = 'display: none !important;';
            } else if (radio.value === 'number') {
                console.log("Showing numberForm, hiding ssnForm");
                document.getElementById('numberForm').style.cssText = 'display: flex !important;';
                document.getElementById('ssnForm').style.cssText = 'display: none !important;';
            }
        });
    }
});