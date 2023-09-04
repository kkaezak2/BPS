package com.bit.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.model.AlarmDTO;
import com.bit.model.AllPaymentDTO;
import com.bit.model.ContractDTO;
import com.bit.model.EmployeeDTO;
import com.bit.model.RefundDTO;
import com.bit.service.AlarmService;
import com.bit.service.AllPaymentService;
import com.bit.service.ContractService;
import com.bit.service.EmployeeService;
import com.bit.service.RefundService;
import com.google.gson.JsonObject;

@RequestMapping("/refund/")
@Controller
public class RefundController {
    private final RefundService REFUND_SERVICE;
    private final AllPaymentService ALLPAYMENT_SERVICE;
    private final ContractService CONTRACT_SERVICE;
    private final EmployeeService EMPLOYEE_SERVICE;
    private final AlarmService ALARM_SERVICE;

    @Autowired
    public RefundController(RefundService refundService, AllPaymentService allPaymentService,
            ContractService contractService, EmployeeService employeeService, AlarmService alarmService) {
        this.REFUND_SERVICE = refundService;
        this.ALLPAYMENT_SERVICE = allPaymentService;
        this.CONTRACT_SERVICE = contractService;
        this.EMPLOYEE_SERVICE = employeeService;
        this.ALARM_SERVICE = alarmService;
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

        return "/refund/printAll";
    }

    // 고객별 계약정보
    @PostMapping("printAll")
    public String printAll(Model model, @RequestParam(value = "number", required = false) int number,
            Authentication authentication) {

        // 증서번호 조회시 계약정보가 없는 경우 메시지를 표시
        List<ContractDTO> contractList = CONTRACT_SERVICE.selectOne(number);
        model.addAttribute("emptyResult", false);
        if (contractList.isEmpty()) {

            model.addAttribute("emptyResult", true);
        }

        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }

        model.addAttribute("allPaymentList", ALLPAYMENT_SERVICE.selectAll(number));
        model.addAttribute("contractList", CONTRACT_SERVICE.selectOne(number));
        model.addAttribute("employeeList", EMPLOYEE_SERVICE.selectApprover());

        return "/refund/printAll";
    }

    @PostMapping("insert")
    public String insert(Authentication auth, HttpSession session,
            @RequestParam("allpaymentId") List<Integer> allpaymentIds, @RequestParam String username,
            @RequestParam String name, @RequestParam String teamName,
            @RequestParam(required = false) Integer applyNumber, @RequestParam String approver, @RequestParam String receiver) {

        EmployeeDTO logIn = (EmployeeDTO) auth.getPrincipal();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String currentDate = dateFormat.format(new Date());

        int applyNum = REFUND_SERVICE.maxApplyNumber(); // 서비스 메서드를 통해 DB에서 maxApplyNumber를 가져옴
        int nextId = applyNum + 1;
        if (applyNumber == null) {
            applyNumber = nextId;
        }

        List<RefundDTO> refundList = new ArrayList<>();

        for (int allPaymentId : allpaymentIds) {
            RefundDTO refundDTO = new RefundDTO();

            refundDTO.setAllPaymentId(allPaymentId);
            refundDTO.setUsername(username);
            refundDTO.setName(name);
            refundDTO.setTeamName(teamName);
            refundDTO.setStatus("결재요청"); // 초기 상태값 설정
            // applyNumber 생성
            refundDTO.setApplyNumber(applyNumber);

            refundList.add(refundDTO);
        }

        REFUND_SERVICE.insert(refundList);

        AlarmDTO alarmDTO = new AlarmDTO();

        alarmDTO.setApprover(approver);
        alarmDTO.setApplyNumber(applyNumber);
        alarmDTO.setReceiver(receiver);
        alarmDTO.setUsername(username);
        alarmDTO.setName(name);
        
        ALARM_SERVICE.insert(alarmDTO);

        return "redirect:/refund/printAll";
    }

    @GetMapping("confirmAll")
    public String confirmAll(Model model, Authentication authentication) {
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }
        model.addAttribute("confirmAllList", REFUND_SERVICE.selectAll());

        return "/refund/confirmAll";
    }

    // 보험료반송조회_고객 조회 화면으로 이동
    @GetMapping("confirmOne/{applyNumber}")
    // @GetMapping("confirmOne")
    public String confirmOne(Model model, Authentication authentication, @PathVariable int applyNumber) {
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }
        model.addAttribute("confirmList", REFUND_SERVICE.selectOne(applyNumber));

        return "/refund/confirmOne";
    }

    // 납입상태 반송 변경하기
    @PostMapping("updateConfirm")
    public String updateConfirm(@RequestParam("allPaymentId") List<Integer> allPaymentIds, AllPaymentDTO allPaymentDTO,
            RefundDTO refundDTO, ContractDTO contractDTO, @RequestParam int applyNumber, @RequestParam int number,
            @RequestParam String approver, @RequestParam String username2, AlarmDTO alarmDTO) {

        allPaymentDTO.setPaymentStatus("반송"); // 변경할 paymentStatus 값을 설정

        for (int allPaymentId : allPaymentIds) {
            allPaymentDTO.setId(allPaymentId);
            refundDTO.setId(allPaymentId);
            ALLPAYMENT_SERVICE.updateConfirm(allPaymentDTO);
        }

        refundDTO.setStatus("결재완료");
        refundDTO.setApprover(approver);
        refundDTO.setUsername2(username2);
        REFUND_SERVICE.updateConfirm(refundDTO);
        CONTRACT_SERVICE.update(contractDTO);
        
      //알람 업데이트
        ALARM_SERVICE.updateChecked(alarmDTO);
        
        return "redirect:/refund/confirmOne/" + refundDTO.getApplyNumber();
    }

// 결재내역조회
    @GetMapping("confirmDone")
    public String confirmDone(Model model, Authentication authentication) {
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }
        model.addAttribute("confirmAllList", REFUND_SERVICE.confirmDone());

        return "/refund/confirmDone";
    }

    // 반송 결재내역 상세조회
    @GetMapping("confirmView/{applyNumber}")
    public String confirmView(Model model, Authentication authentication, @PathVariable int applyNumber) {
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }
        model.addAttribute("confirmList", REFUND_SERVICE.selectOne(applyNumber));

        return "/refund/confirmView";
    }

// 결재상태 반려 변경하기
    @ResponseBody
    @PostMapping(value = "updateReject/{applyNumber}", produces = "application/text; charset=utf8")
    public String updateReject(RefundDTO refundDTO, @RequestParam int applyNumber, @RequestParam String approver,
            @RequestParam String username2, AlarmDTO alarmDTO) {

        JsonObject jsonObject = new JsonObject();

        refundDTO.setStatus("반려");
        refundDTO.setApprover(approver);
        refundDTO.setUsername2(username2);
        REFUND_SERVICE.updateReject(refundDTO);

      //알람 업데이트
        ALARM_SERVICE.updateChecked(alarmDTO);
        
        jsonObject.addProperty("result", "success");
        jsonObject.addProperty("message", "반려완료!");

        return jsonObject.toString();
    }

// 결재상태 상신취소 변경하기
    @PostMapping("updateCancel/{applyNumber}")
    public String updateReject(RefundDTO refundDTO, @PathVariable int applyNumber, AlarmDTO alarmDTO) {

        refundDTO.setStatus("상신취소");

        REFUND_SERVICE.updateCancel(refundDTO);
        
      //알람 업데이트
        ALARM_SERVICE.updateChecked(alarmDTO);

        return "redirect:/refund/confirmOne/" + refundDTO.getApplyNumber();
    }
    
    // 반송 결재요청 중복체크
    @ResponseBody
    @PostMapping("refundCheck/{allpaymentId}")
    public int refundCheck(Authentication auth,
            @PathVariable("allpaymentId") int allpaymentId) {
        
        int cnt = REFUND_SERVICE.refundCheck(allpaymentId); 

        return cnt;
    }
    
    // 알람 checked 업데이트
    @PostMapping("updateAlarm/{applyNumber}")
    public String updateAlarm(@PathVariable int applyNumber, AlarmDTO alarmDTO) {    
      //알람 업데이트
        ALARM_SERVICE.updateChecked(alarmDTO);

        return "redirect:/";
    }
}