package com.bit.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.model.AllPaymentDTO;
import com.bit.model.EmployeeDTO;
import com.bit.service.AllPaymentService;
import com.bit.service.EmployeeService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Controller
public class HomeController {

    private final EmployeeService EMPLOYEE_SERVICE;
    private final AllPaymentService ALLPAYMENT_SERVICE;

    @Autowired
    public HomeController(EmployeeService employeeService, BCryptPasswordEncoder passwordEncoder,
            AllPaymentService allPaymentService) {
        this.EMPLOYEE_SERVICE = employeeService;
        this.ALLPAYMENT_SERVICE = allPaymentService;
    }

    @RequestMapping("/")
    public String showIndex() {
        System.out.println("★인덱스 화면 요청★");
        return "index";
    }

    @RequestMapping("main")
    public String showMain(Model model, Authentication authentication) {
        System.out.println("★메인화면요청★");

        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }
        return "main";
    }

    @RequestMapping("dashboard/index")
    public String showDashboard(Model model,
          @RequestParam(value = "startDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
            @RequestParam(value = "endDate", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate) {
        
        // 날짜가 입력되지 않았을 때 기본값 설정
        if (startDate == null) {
            startDate = LocalDate.now().minusMonths(12); 
        }
        if (endDate == null) {
            endDate = LocalDate.now();
        }
        
        List<AllPaymentDTO> countList = ALLPAYMENT_SERVICE.countByDate(); // 날짜별 처리건수
        List<AllPaymentDTO> countList2 = ALLPAYMENT_SERVICE.countByName(); // 인별 처리건수
        List<AllPaymentDTO> countList3 = ALLPAYMENT_SERVICE.countByMethod(); // 인별 처리건수
        List<AllPaymentDTO> countList4 = ALLPAYMENT_SERVICE.premiumByProduct(); // 상품별 보험료
        List<AllPaymentDTO> countList5 = ALLPAYMENT_SERVICE.premiumByMonth(startDate, endDate); // 월별 보험료
        
        Gson gson = new Gson();
        JsonArray jArray = new JsonArray();
        
     // 날짜별 처리건수
        Iterator<AllPaymentDTO> ap = countList.iterator();
        while(ap.hasNext()) {
           AllPaymentDTO allPaymentDTO = ap.next();
           
           JsonObject object = new JsonObject();
           Date processDate = allPaymentDTO.getProcessDate();
           int count = allPaymentDTO.getPaymentCount();
           
           // Date type을 String으로 변환
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = dateFormat.format(processDate);
            
            // object에 담아서 전달
            object.addProperty("processDate", formattedDate);
           object.addProperty("count", count);
           jArray.add(object);
        }
        
        // 인별 처리건수
        Iterator<AllPaymentDTO> ap2 = countList2.iterator();
        while(ap2.hasNext()) {
           AllPaymentDTO allPaymentDTO = ap2.next();
           
           JsonObject object = new JsonObject();
           String name = allPaymentDTO.getName();
           int count2 = allPaymentDTO.getPaymentCount();
           
            object.addProperty("name", name);
           object.addProperty("count2", count2);
           jArray.add(object);
        } 
        
        // 납입방법별 건수
        Iterator<AllPaymentDTO> ap3 = countList3.iterator();
        while(ap3.hasNext()) {
           AllPaymentDTO allPaymentDTO = ap3.next();
           
           JsonObject object = new JsonObject();
           String method = allPaymentDTO.getPaymentMethod();
           int count3 = allPaymentDTO.getPaymentCount();
           
            object.addProperty("method", method);
           object.addProperty("count3", count3);
           jArray.add(object);
        } 
        
        // 상품별 보험료
        Iterator<AllPaymentDTO> ap4 = countList4.iterator();
        while(ap4.hasNext()) {
           AllPaymentDTO allPaymentDTO = ap4.next();
           
           JsonObject object = new JsonObject();
           String product = allPaymentDTO.getProductName();
           int premium = allPaymentDTO.getPremium();
           
           object.addProperty("product", product);
           object.addProperty("premium", premium);
           jArray.add(object);
        }
        
        // 월별 보험료
        Iterator<AllPaymentDTO> ap5 = countList5.iterator();
        while(ap5.hasNext()) {
           AllPaymentDTO allPaymentDTO = ap5.next();
           
           JsonObject object = new JsonObject();
           String month = allPaymentDTO.getMonth();
           int premium2 = allPaymentDTO.getPremium();
                            
           object.addProperty("month", month);
           object.addProperty("premium2", premium2);
           jArray.add(object);
        }
              
        String json = gson.toJson(jArray);
        model.addAttribute("json", json);
      
        return "/dashboard/index";
    }    
}
