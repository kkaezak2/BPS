package com.bit.controller;

import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bit.model.AccountDTO;
import com.bit.model.ContractDTO;
import com.bit.model.EmployeeDTO;
import com.bit.service.AccountService;
import com.bit.service.ContractService;
import com.bit.service.CustomerService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@RequestMapping("/contract/")
@Controller
public class ContractController {

    private final ContractService CONTRACT_SERVICE;
    private final CustomerService CUSTOMER_SERVICE;
    private final AccountService ACCOUNT_SERVICE;

    @Autowired
    public ContractController(ContractService contractService, CustomerService customerService,
            AccountService accountService) {
        this.CONTRACT_SERVICE = contractService;
        this.CUSTOMER_SERVICE = customerService;
        this.ACCOUNT_SERVICE = accountService;
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
        model.addAttribute("emptyResult", false);

        return "/contract/printAll";
    }

    // 고객별 계약정보(주민번호)
    @PostMapping("printAll")
    public String printAll(Model model, @RequestParam(value = "ssn", required = true) String ssn,
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

        while (al.hasNext()) {
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

        model.addAttribute("contractList", CONTRACT_SERVICE.selectAllByCustomer(ssn));
        model.addAttribute("customerList", CUSTOMER_SERVICE.selectOne(ssn));
        model.addAttribute("accountList", ACCOUNT_SERVICE.selectAll(ssn));

        String json = gson.toJson(jArray);
        model.addAttribute("json", json);

        return "/contract/printAll";
    }

    // 고객별 계약정보(증서번호)
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

        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }

        Gson gson = new Gson();
        JsonArray jArray = new JsonArray();
        Iterator<AccountDTO> al = accList.iterator();

        while (al.hasNext()) {
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
        model.addAttribute("contractList", CONTRACT_SERVICE.selectOne(number));
        model.addAttribute("accountList", ACCOUNT_SERVICE.selectOne(number));

        String json = gson.toJson(jArray);
        model.addAttribute("json", json);

        return "/contract/printAll";
    }
}