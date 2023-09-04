package com.bit.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.model.AccountDTO;
import com.bit.model.AutoPaymentDTO;
import com.bit.model.ContractDTO;
import com.bit.model.EmployeeDTO;
import com.bit.service.AccountService;
import com.bit.service.AutoPaymentService;
import com.bit.service.ContractService;
import com.bit.service.CustomerService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;



@RequestMapping("/autopayment/")
@Controller
public class AutoPaymentController {
   
   private final AutoPaymentService AUTOPAYMENT_SERVICE;
   private final ContractService CONTRACT_SERVICE;
   private final CustomerService CUSTOMER_SERVICE;
   private final AccountService ACCOUNT_SERVICE;
   
   @Autowired
       public AutoPaymentController(AutoPaymentService autoPaymentService, ContractService contractService,CustomerService customerService, AccountService accountService) {
         
        this.AUTOPAYMENT_SERVICE = autoPaymentService;
        this.CONTRACT_SERVICE = contractService;
        this.CUSTOMER_SERVICE = customerService;
        this.ACCOUNT_SERVICE = accountService;
    }
   
   @Autowired
   private JavaMailSender mailSender;
   
   // 자동이체뷰
   @GetMapping("printAll")
   public String showPrintAll(Model model, Authentication authentication) {
       if (authentication != null) {
           EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

           model.addAttribute("logInusername", logIn.getUsername());
           model.addAttribute("logInname", logIn.getName());
           model.addAttribute("logIngrade", logIn.getGrade());
           model.addAttribute("logInteamcode", logIn.getTeamCode());
           model.addAttribute("logInteamname", logIn.getTeamName());
       }

       model.addAttribute("emptyResult", false);
       
       return "/autopayment/printAll";
   }

   // 자동이체실행
   @PostMapping("printAll")
   public String printAll(Model model, @RequestParam(value = "ssn", required = false) String ssn,
           Authentication authentication) {
       
       // 주민번호 조회시 계약정보가 없는 경우 메시지를 표시
       List<ContractDTO> contractList = CONTRACT_SERVICE.selectAllByCustomer(ssn);
       model.addAttribute("emptyResult", false);
       if (contractList.isEmpty()) {
           model.addAttribute("emptyResult", true);
       }
       
       List<AccountDTO> accList = ACCOUNT_SERVICE.selectAll(ssn);
       
       Gson gson = new Gson();
       JsonArray jArray = new JsonArray();
       Iterator<AccountDTO> al = accList.iterator();
       
       while(al.hasNext()) {
           AccountDTO accountDTO = al.next();
          
          JsonObject object = new JsonObject();
          String bank = accountDTO.getBank();
          int account = accountDTO.getAccount();
          String depositor = accountDTO.getDepositor();
           
           // object에 담아서 전달
          object.addProperty("bank", bank);
          object.addProperty("account", account);
          object.addProperty("depositor", depositor);
          jArray.add(object);
       }
       

       if (authentication != null) {
           EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

           model.addAttribute("logInusername", logIn.getUsername());
           model.addAttribute("logInname", logIn.getName());
           model.addAttribute("logIngrade", logIn.getGrade());
           model.addAttribute("logInteamcode", logIn.getTeamCode());
           model.addAttribute("logInteamname", logIn.getTeamName());
       }
       model.addAttribute("autoPaymentList", AUTOPAYMENT_SERVICE.selectAll(ssn));  //지헌
       model.addAttribute("contractList", CONTRACT_SERVICE.selectAllByCustomer(ssn));
       model.addAttribute("customerList", CUSTOMER_SERVICE.selectOne(ssn));
       model.addAttribute("accountList", ACCOUNT_SERVICE.selectAll(ssn)); //계좌정보 조회(지헌)
       model.addAttribute("combinedList", CONTRACT_SERVICE.selectSsnOneCombined(ssn)); // 계좌정보조회(dk,inner join)
       
       String json = gson.toJson(jArray);
       model.addAttribute("json", json);
       
       return "/autopayment/printAll";
   }
   
    
 // 고객 조회 화면으로 이동(삭제하면 안됨)
   @GetMapping("printOne")
    public String showPrintOne(Model model, Authentication authentication) {
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();
            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }
   
        model.addAttribute("emptyResult", false);
        return "/autopayment/printOne";
    }
    
    
    
 // 고객별 계약정보(증서번호)_지헌
    @PostMapping("printOne")
    public String printOne(Model model, @RequestParam(value = "number", required = false) int number,
            Authentication authentication) {
     // 증서번호 조회시 계약정보가 없는 경우 메시지를 표시 
        List<ContractDTO> contractList = CONTRACT_SERVICE.selectOne(number);
        model.addAttribute("emptyResult", false);
        if (contractList.isEmpty()) {   
            model.addAttribute("emptyResult", true);
        }
        
        List<AccountDTO> accList = ACCOUNT_SERVICE.selectOne(number);
        
        Gson gson = new Gson();
        JsonArray jArray = new JsonArray();
        Iterator<AccountDTO> al = accList.iterator();
        
        while(al.hasNext()) {
            AccountDTO accountDTO = al.next();
           
           JsonObject object = new JsonObject();
           String bank = accountDTO.getBank();
           int account = accountDTO.getAccount();
           String depositor = accountDTO.getDepositor();
            
            // object에 담아서 전달
           object.addProperty("bank", bank);
           object.addProperty("account", account);
           object.addProperty("depositor", depositor);
           jArray.add(object);
        }

        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }

        model.addAttribute("contractList", CONTRACT_SERVICE.selectOne(number));
        model.addAttribute("autoPaymentList", AUTOPAYMENT_SERVICE.selectOne(number));
        model.addAttribute("accountList", ACCOUNT_SERVICE.selectOne(number)); //순정 매니저님 추가
        model.addAttribute("combinedList", CONTRACT_SERVICE.selectOneCombined(number)); // 자동이체내역조회
        
        String json = gson.toJson(jArray);
        model.addAttribute("json", json);
        
        return "/autopayment/printAll";
    }
    
 // 자동이체 정보 수정_지헌,동규
    @GetMapping("insert")
    public String showUpdate(Model model,@RequestParam int number) {
        
        model.addAttribute("autoPaymentList", AUTOPAYMENT_SERVICE.selectOne(number));
        model.addAttribute("emptyResult", false);
        return "/autopayment/insert";
    }
    
 // 자동이체 정보 수정하기_지헌,동규
    @ResponseBody
    @PostMapping(value = "insert", produces = "application/text; charset=utf-8")
    public String update(@RequestBody ArrayList<AutoPaymentDTO> autoPaymentArrayList) {
        JsonObject jsonObject = new JsonObject();

        try {
            List<AutoPaymentDTO> autoPaymentList = new ArrayList<>();
            for (AutoPaymentDTO autoPaymentDTO : autoPaymentArrayList) {
                autoPaymentList.add(autoPaymentDTO);
            }
            AUTOPAYMENT_SERVICE.insert(autoPaymentList);

            jsonObject.addProperty("result", "success");
            jsonObject.addProperty("message", "자동이체 변경완료!");
        } catch (Exception e) {
            e.printStackTrace(); // 오류 로깅
            jsonObject.addProperty("result", "fail");
            jsonObject.addProperty("message", "실패 : 다시 확인해주세요!");
        }
        return jsonObject.toString();
    }
    
    
 // 자동이체내역조회(주민번호)
    @PostMapping("printAlldetail")
    public String printAlldetail(Model model,
            @RequestParam(value = "ssn", required = false) String ssn,
            @RequestParam(value = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam(value = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
            Authentication authentication) {
        
        // 주민번호 조회시 계약정보가 없는 경우 메시지를 표시
        List<ContractDTO> contractList = CONTRACT_SERVICE.selectAllByCustomer(ssn);
        model.addAttribute("emptyResult", false);
        if (contractList.isEmpty()) {
            model.addAttribute("emptyResult", true);
        }
        
     // 날짜가 입력되지 않았을 때 기본값 설정
        if (startDate == null) {
            startDate = LocalDate.now().minusDays(20); // 숫자로 디폴트 조회 일수 입력
        }
        if (endDate == null) {
            endDate = LocalDate.now();
        }
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }

        model.addAttribute("autoPaymentList", AUTOPAYMENT_SERVICE.selectAll(ssn));  //지헌
        model.addAttribute("contractList", CONTRACT_SERVICE.selectAllByCustomer(ssn));
        model.addAttribute("customerList", CUSTOMER_SERVICE.selectOne(ssn));
        model.addAttribute("accountList", ACCOUNT_SERVICE.selectAll(ssn)); //계좌정보 조회(지헌)
        model.addAttribute("combinedList", CONTRACT_SERVICE.selectssncombined(ssn, startDate, endDate)); // 계좌정보조회(dk,inner join)
        
        return "/autopayment/printOne";
    }
    
 // 자동이체내역조회(증서번호)
    @PostMapping("printOnedetail")
    public String printOnedetail(Model model, @RequestParam(value = "number", required = false) int number,
            @RequestParam(value = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam(value = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
            Authentication authentication) {
        
     // 증서번호 조회시 계약정보가 없는 경우 메시지를 표시 
        List<ContractDTO> contractList = CONTRACT_SERVICE.selectOne(number);
        model.addAttribute("emptyResult", false);
        if (contractList.isEmpty()) {   
            model.addAttribute("emptyResult", true);
        }
        
        // 날짜가 입력되지 않았을 때 기본값 설정
        if (startDate == null) {
            startDate = LocalDate.now().minusDays(20); // 숫자로 디폴트 조회 일수 입력
        }
        if (endDate == null) {
            endDate = LocalDate.now();
        }
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }

        model.addAttribute("contractList", CONTRACT_SERVICE.selectOne(number));
        model.addAttribute("autoPaymentList", AUTOPAYMENT_SERVICE.selectOne(number));
        model.addAttribute("combinedList", CONTRACT_SERVICE.selectcombined(number, startDate, endDate)); // 계좌정보조회(dk,inner join)
        
        return "/autopayment/printOne";
    }
    
    // 변경내역메일발송위한 form
    private String buildContent(List<ContractDTO> combinedList) {
        String content = "<table style=\"width:100%;\">"
                + "<tr><td style=\"width:12.5%;\">증서번호</td><td style=\"width:12.5%;\">상품명</td><td style=\"width:12.5%;\">보험료</td><td style=\"width:12.5%;\">계약상태</td>"
                + "<td style=\"width:12.5%;\">납입방법</td><td style=\"width:12.5%;\">자동이체일자</td><td style=\"width:12.5%;\">은행명</td><td style=\"width:12.5%;\">계좌번호</td></tr>";

        for (ContractDTO combined : combinedList) {
            content += "<tr>"
                    + "<td>" + combined.getNumber() + "</td>"
                    + "<td>" + combined.getProductName() + "</td>"
                    + "<td>" + String.format("%,d", combined.getPremium()) + "</td>"
                    + "<td>" + combined.getStatus() + "</td>"
                    + "<td>" + combined.getPaymentMethod() + "</td>"
                    + "<td>" + combined.getAccountDate() + "</td>"
                    + "<td>" + combined.getBank() + "</td>"
                    + "<td>" + (combined.getAccount() == 0 ? "" : combined.getAccount()) + "</td>"
                    + "</tr>";
        }

        content += "</table>";
        return content;
    }
    
    // 변경내역 고객 이메일발송
    @PostMapping("sendEmail")
    public String sendEmailAutoPayment(Model model, @RequestParam String emailAddress, @RequestParam String ssn) throws Exception {
        List<ContractDTO> combinedList = CONTRACT_SERVICE.selectSsnOneCombined(ssn);
        model.addAttribute("combinedList", combinedList);

        List<ContractDTO> customerContracts = CONTRACT_SERVICE.selectAllByCustomer(ssn);
        final String subject; // final 키워드를 사용
        if (customerContracts != null && !customerContracts.isEmpty()) {
            subject = "[BPS]"+customerContracts.get(0).getContractor()+"고객님 자동이체 변경내역 입니다."; // 첫 번째 항목의 contractor 값
        } else {
            subject = "[BPS]고객님 자동이체 변경내역 입니다"; // 비어있는 경우 기본 제목 설정
        }

        final String content = buildContent(combinedList);

        String from = "grop7@naver.com";
        String to = emailAddress;

        MimeMessagePreparator preparator = mimeMessage -> {
            final MimeMessageHelper mailHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            mailHelper.setFrom(from);
            mailHelper.setTo(to);
            mailHelper.setSubject(subject); // 이제 subject는 final이므로 문제가 없음
            mailHelper.setText(content, true);
        };

        try {
            mailSender.send(preparator);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/autopayment/printOne";
    }
}
