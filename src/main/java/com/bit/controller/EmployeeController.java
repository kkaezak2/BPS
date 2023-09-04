package com.bit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.model.EmployeeDTO;
import com.bit.service.EmployeeService;
import com.google.gson.JsonObject;

@RequestMapping("/employee/")
@Controller
public class EmployeeController {
    private final EmployeeService EMPLOYEE_SERVICE;
    private final PasswordEncoder ENCODER;

    @Autowired
    public EmployeeController(EmployeeService employeeService, BCryptPasswordEncoder passwordEncoder) {
        this.EMPLOYEE_SERVICE = employeeService;
        this.ENCODER = passwordEncoder;
    }

    // 직원등록
    @GetMapping("register")
    public String showRegister(Model model, Authentication authentication) {

        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }
        return "/employee/register";
    }

    public void register(EmployeeDTO attempt) {
        attempt.setPassword(encryptPW(attempt.getPassword()));
        EMPLOYEE_SERVICE.register(attempt);
    }

    // 직원등록실행
    @ResponseBody
    @PostMapping(value = "validate", produces = "application/text; charset=utf8")
    public String validateUsername(EmployeeDTO employeeDTO) {
        JsonObject jsonObject = new JsonObject();
        if (EMPLOYEE_SERVICE.loadUserByUsername(employeeDTO.getUsername()) == null) {
            register(employeeDTO);
            jsonObject.addProperty("result", "success");
            jsonObject.addProperty("message", "직원등록완료!");
        } else {
            // 직원의 username이 존재하는경우
            jsonObject.addProperty("result", "fail");
            jsonObject.addProperty("message", "이미 존재하는 직원사번입니다!");
        }

        return jsonObject.toString();
    }

    private String encryptPW(String password) {
        return ENCODER.encode(password);
    }
    
    // 직원비밀번호 변경하기
    @ResponseBody
    @PostMapping(value= "updatePassword/{username}", produces = "application/text; charset=utf8")
    public String updatePassword(@PathVariable String username, EmployeeDTO employeeDTO) {
        JsonObject jsonObject = new JsonObject();
        System.out.println(employeeDTO);

        employeeDTO.setUsername(username);
        employeeDTO.setPassword(encryptPW(employeeDTO.getPassword()));
        
        try {
            
            EMPLOYEE_SERVICE.updatePassword(employeeDTO);
            
            jsonObject.addProperty("result", "success");
            jsonObject.addProperty("message", "비밀번호 변경완료!");
        }catch(Exception e) {
            jsonObject.addProperty("result", "fail");
            jsonObject.addProperty("message", "비밀번호 변경에 실패했습니다!");
        }
        return jsonObject.toString();
    }
    
    @GetMapping("printAll")
    public String printAll() {
        return "redirect:/employee/printAll/1";
    }

    // 직원보기_페이징업그레이드
    @GetMapping("printAll/{pageNo}")
    public String printAll(@PathVariable int pageNo, Model model, Authentication authentication) {

        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }

        int maxPage = EMPLOYEE_SERVICE.selectMaxPage();
        int startPage = 0;
        int endPage = 0;

        // 순서가 중요함
        // 만약 maxPage가 5 이하일 경우
        if (maxPage <= 5) {
            startPage = 1;
            endPage = maxPage;
        } else if (pageNo <= 3) {
            // 만약 pageNo가 3 이하일 경우
            startPage = 1;
            endPage = 5;
        } else if (pageNo >= maxPage - 2) {
            // 만약 pageNo가 maxPage -2 이상일 경우
            startPage = maxPage - 4;
            endPage = maxPage;
        } else {
            // 그외의 경우
            startPage = pageNo - 2;
            endPage = pageNo + 2;
        }

        model.addAttribute("list", EMPLOYEE_SERVICE.selectAll(pageNo));
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("maxPage", maxPage);

        return "/employee/printAll";
    }

    // 직원 삭제하기
    @GetMapping("delete/{username}")
    public String delete(Authentication authentication, @PathVariable String username) {

        EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

        EmployeeDTO employeeDTO = EMPLOYEE_SERVICE.selectOne(username);

        if (employeeDTO == null) {
            return "redirect:/employee/printAll";
        }
        EMPLOYEE_SERVICE.delete(username);

        return "redirect:/employee/printAll";
    }

    // 직원권한 수정하기
    @PostMapping("updateGrade/{username}")
    public String updateGrade(@PathVariable String username, EmployeeDTO employeeDTO) {

        employeeDTO.setUsername(username);

        EMPLOYEE_SERVICE.updateGrade(employeeDTO);

        return "redirect:/employee/printAll/";
    }

    // 직원검색
    @GetMapping("search")
    public String search(Model model, @RequestParam(value = "search", required = false) String search,
            Authentication authentication) {

        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }

        search = "%" + search + "%";
        List<EmployeeDTO> list = EMPLOYEE_SERVICE.search(search);
        model.addAttribute("list", list);
        return "employee/printAll";
    }
}