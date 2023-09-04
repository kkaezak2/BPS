package com.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.model.ContractDTO;
import com.bit.model.EmployeeDTO;
import com.bit.service.ContractService;
import com.bit.service.CustomerService;

@RequestMapping("/customer/")
@Controller
public class CustomerController {
   
   private final CustomerService CUSTOMER_SERVICE;
   private final ContractService CONTRACT_SERVICE;
   
   @Autowired
    public CustomerController(CustomerService customerService, ContractService contractService) {
        this.CUSTOMER_SERVICE = customerService;
        this.CONTRACT_SERVICE = contractService;
    }
    
 // 고객 조회 화면으로 이동
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
        return "/customer/printOne";
    }
   
   // 고객별 계약정보(주민번호)
    @PostMapping("printOne")
    public String printOne(Model model, @RequestParam(value="ssn", required=false) String ssn, Authentication authentication, ContractDTO contractDTO) {

        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }
        
        List<ContractDTO> contractList = CONTRACT_SERVICE.selectAllByCustomer(ssn);
        model.addAttribute("emptyResult", false);
        if(contractList.isEmpty()) {
        model.addAttribute("emptyResult", true);
        }
        
        model.addAttribute("customerList", CUSTOMER_SERVICE.selectOne(ssn));
        model.addAttribute("contractList", CONTRACT_SERVICE.selectAllByCustomer(ssn));

        return "/customer/printOne";
    }
}