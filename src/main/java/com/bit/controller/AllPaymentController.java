package com.bit.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.model.AllPaymentDTO;
import com.bit.model.ContractDTO;
import com.bit.model.EmployeeDTO;
import com.bit.service.AllPaymentService;
import com.bit.service.ContractService;
import com.bit.service.CustomerService;
import com.google.gson.JsonObject;

@RequestMapping("/allpayment/")
@Controller
public class AllPaymentController {
    private final AllPaymentService ALLPAYMENT_SERVICE;
    private final ContractService CONTRACT_SERVICE;

    @Autowired
    public AllPaymentController(AllPaymentService allPaymentService, ContractService contractService) {
        this.ALLPAYMENT_SERVICE = allPaymentService;
        this.CONTRACT_SERVICE = contractService;
    }

    // 납입내역실행
    @ResponseBody
    @PostMapping(value = "insert", produces = "application/text; charset=utf8")
    public String insert(Authentication auth, HttpSession session, @RequestParam int number,
            @RequestParam String startDate, @RequestParam String endDate, @RequestParam String ssn,
            @RequestParam String name, @RequestParam String teamname, @RequestParam String username,
            @RequestParam String bank, @RequestParam int account, @RequestParam String depositor,
            ContractDTO contractDTO) {

        JsonObject jsonObject = new JsonObject();
        EmployeeDTO logIn = (EmployeeDTO) auth.getPrincipal();
        SimpleDateFormat inputDateFormat = new SimpleDateFormat("yyyy-MM"); // 입력된 날짜 형식
        SimpleDateFormat dbDateFormat = new SimpleDateFormat("yyyy-MM"); // DB에 저장할 날짜 형식
        Calendar cal = Calendar.getInstance();

        try {
            cal.setTime(inputDateFormat.parse(startDate));
            String endDateStr = endDate;

            List<AllPaymentDTO> allPaymentList = new ArrayList<>();
            List<ContractDTO> contractList = new ArrayList<>();

            while (!inputDateFormat.format(cal.getTime()).equals(endDateStr)) {
                AllPaymentDTO allPaymentDTO = new AllPaymentDTO();
                Date paidDate = new Date(cal.getTimeInMillis());
                allPaymentDTO.setNumber(number);
                allPaymentDTO.setSsn(ssn);
                allPaymentDTO.setName(name);
                allPaymentDTO.setTeamName(teamname);
                allPaymentDTO.setUsername(username);
                allPaymentDTO.setBank(bank);
                allPaymentDTO.setAccount(account);
                allPaymentDTO.setDepositor(depositor);
                allPaymentDTO.setPaidDate(paidDate);
                allPaymentDTO.setCount(1);
                allPaymentList.add(allPaymentDTO);

                cal.add(Calendar.MONTH, 1); // 1달씩 더함
            }

            // 종료일에 해당하는 데이터 추가
            AllPaymentDTO allPaymentDTO = new AllPaymentDTO();
            Date paidDate = new Date(cal.getTimeInMillis());
            allPaymentDTO.setNumber(number);
            allPaymentDTO.setSsn(ssn);
            allPaymentDTO.setName(name);
            allPaymentDTO.setTeamName(teamname);
            allPaymentDTO.setUsername(username);
            allPaymentDTO.setBank(bank);
            allPaymentDTO.setAccount(account);
            allPaymentDTO.setDepositor(depositor);
            allPaymentDTO.setPaidDate(paidDate);
            allPaymentDTO.setCount(1);
            allPaymentList.add(allPaymentDTO);

            ALLPAYMENT_SERVICE.insert(allPaymentList);
            ALLPAYMENT_SERVICE.updateCount(allPaymentDTO);
            CONTRACT_SERVICE.update(contractDTO);

            jsonObject.addProperty("result", "success");
            jsonObject.addProperty("message", "출금완료!");

        } catch (ParseException e) {
            e.printStackTrace();

            jsonObject.addProperty("result", "fail");
            jsonObject.addProperty("message", "출금이 실패했습니다!");

            // 예외 처리
        }
        
        return jsonObject.toString(); // JSON 형식으로 변환된 문자열을 반환
    }

    // 고객 조회 화면으로 이동
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

        return "/allpayment/printAll";
    }

    // 고객별 계약정보
    @PostMapping("printAll")
    public String printAll(Model model, @RequestParam(value = "number", required = false) int number,
            Authentication authentication, @RequestParam("paymentStatus") String paymentStatus) {

        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }

        model.addAttribute("allPaymentList", ALLPAYMENT_SERVICE.selectAllByContract(number, paymentStatus));
        model.addAttribute("contractList", CONTRACT_SERVICE.selectOne(number));

        return "/allpayment/printAll";
    }

    
 // 즉시이체결과조회화면으로 이동
    @GetMapping("printDetail")
    public String showPrintDetail(Model model, Authentication authentication) {
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }

        return "/allpayment/printDetail";
    }
    
    
    // 즉시이체결과 증번별 납입상태별 조회
    @PostMapping("printDetail")
    public String printDetail(Model model, Authentication authentication, @RequestParam(value = "number", required = false) int number,
            @RequestParam("paymentStatus") String paymentStatus) {        
        
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }
        
        model.addAttribute("allPaymentList", ALLPAYMENT_SERVICE.selectAllByContract(number, paymentStatus));

        return "/allpayment/printDetail";
    }  
}