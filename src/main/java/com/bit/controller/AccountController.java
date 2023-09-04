package com.bit.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.model.AccountDTO;
import com.bit.service.AccountService;
import com.google.gson.JsonObject;

@RequestMapping("/account/")
@Controller
public class AccountController {
    private final AccountService ACCOUNT_SERVICE;
    
    @Autowired
    public AccountController(AccountService accountService) {
        this.ACCOUNT_SERVICE = accountService;
    }

    // 계좌등록뷰
    @GetMapping("register")
    public String showRegister(Model model) {
        return "/account/register";
    }

    // 계좌등록실행
    @ResponseBody
    @PostMapping(value = "register", produces = "application/text; charset=utf-8")
    public String register(AccountDTO accountDTO) {
        
        JsonObject jsonObject = new JsonObject();

        try {
            ACCOUNT_SERVICE.register(accountDTO);
            jsonObject.addProperty("result", "success");
            jsonObject.addProperty("message", "계좌등록완료!");
        } catch(Exception e) {
            jsonObject.addProperty("result", "fail");
            jsonObject.addProperty("message", "이미 등록된 계좌정보 입니다!");
        }
        return jsonObject.toString();
    }
}