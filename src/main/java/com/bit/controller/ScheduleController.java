package com.bit.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;

import com.bit.model.AttachmentDTO;
import com.bit.model.EmployeeDTO;
import com.bit.model.NoticeDTO;
import com.bit.model.ScheduleDTO;
import com.bit.service.AttachmentService;
import com.bit.service.NoticeService;
import com.bit.service.RefundService;
import com.bit.service.ScheduleService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@RequestMapping("/")
@Controller
public class ScheduleController {
    private final ScheduleService SCHEDULE_SERVICE;
    private final RefundService REFUND_SERVICE;
    private final NoticeService NOTICE_SERVICE;
    private final AttachmentService ATTACHMENT_SERVICE;
    private final String UPLOAD_PATH = "/upload";

    @Autowired
    public ScheduleController(ScheduleService scheduleService, RefundService refundService, NoticeService noticeService,
            AttachmentService attachmentService) {
        this.SCHEDULE_SERVICE = scheduleService;
        this.REFUND_SERVICE = refundService;
        this.NOTICE_SERVICE = noticeService;
        this.ATTACHMENT_SERVICE = attachmentService;
    }

    // 일정등록
    @ResponseBody
    @PostMapping(value = "validate", produces = "application/text; charset=utf8")
    public String addSchedule(ScheduleDTO scheduleDTO, String id) {
        JsonObject jsonObject = new JsonObject();

        SCHEDULE_SERVICE.addSchedule(scheduleDTO);

        jsonObject.addProperty("result", "success");
        jsonObject.addProperty("message", "일정등록완료!");

        return jsonObject.toString();
    }

    // 일정출력
    @ResponseBody
    @GetMapping(value = "/getEvents", produces = "application/json; charset=utf-8")
    public String getEvents(Model model, Authentication authentication) {

        String username = null;
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();
            model.addAttribute("logInusername", logIn.getUsername());
            username = logIn.getUsername();
        }

        List<ScheduleDTO> schedules = SCHEDULE_SERVICE.getAllSchedulesByWriter(username);

        // 일정 데이터에 id 필드를 추가하여 전송
        List<Map<String, Object>> eventDataList = new ArrayList<>();
        for (ScheduleDTO schedule : schedules) {
            Map<String, Object> eventData = new HashMap<>();
            eventData.put("id", schedule.getId()); // 일정의 고유 ID를 추가
            eventData.put("title", schedule.getTitle());
            eventData.put("start", schedule.getStart());
            eventData.put("end", schedule.getEnd());
            eventDataList.add(eventData);
        }

        Gson gson = new Gson();
        return gson.toJson(eventDataList);
    }

    // 결재요청정보, 공지사항 출력용(뷰)
    @GetMapping("main")
    public String redirectUrl(Model model, Authentication authentication) {
        if (authentication != null) {
            EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

            model.addAttribute("logInusername", logIn.getUsername());
            model.addAttribute("logInname", logIn.getName());
            model.addAttribute("logIngrade", logIn.getGrade());
            model.addAttribute("logInteamcode", logIn.getTeamCode());
            model.addAttribute("logInteamname", logIn.getTeamName());
        }
        // URL에 해당하는 데이터를 모델에 추가하는 코드

        model.addAttribute("confirmAllList", REFUND_SERVICE.selectAll());
        model.addAttribute("noticeAllList", NOTICE_SERVICE.selectAll());
        model.addAttribute("refundAllList", REFUND_SERVICE.selectAll());
        model.addAttribute("confirmDoneList", REFUND_SERVICE.confirmDone());
        model.addAttribute("attachmentList", ATTACHMENT_SERVICE.selectAllAttached());
        return "/main"; // 실제로 리다이렉트될 URL
    }

    // 일정삭제
    @ResponseBody
    @PostMapping(value = "/deleteEvents/{id}", produces = "application/json; charset=utf8")
    public String delete(@PathVariable int id) {
        JsonObject jsonObject = new JsonObject();

        try {
            SCHEDULE_SERVICE.delete(id);
            jsonObject.addProperty("result", "success");
            jsonObject.addProperty("message", "일정삭제완료!");
        } catch (Exception e) {
            e.printStackTrace(); // 서버 쪽 에러 로그 출력
            jsonObject.addProperty("result", "fail");
            jsonObject.addProperty("message", "일정삭제실패!");
        }
        return jsonObject.toString();
    }

    
 // 공지사항등록 파일첨부 추가
        @PostMapping("notice")
        public String addNotice(Model model, Authentication authentication, HttpSession session, 
                @RequestParam String writerId,  
                @RequestParam String writer, 
                @RequestParam String title,
                @RequestParam String content,
                @RequestParam("file") List<MultipartFile> files) {
           
            
            NoticeDTO noticeDTO = new NoticeDTO();
            
            noticeDTO.setWriterId(writerId);
            noticeDTO.setWriter(writer);
            noticeDTO.setTitle(title);
            noticeDTO.setContent(content);   
                        
            NOTICE_SERVICE.insert(noticeDTO);

            String uploadPath = session.getServletContext().getRealPath("/") + "upload/" + noticeDTO.getId();
            
            File dir = new File(uploadPath);
            if(!dir.exists()) {
                dir.mkdirs();
            }
            
            ArrayList<AttachmentDTO> attachedList = new ArrayList<>();
            
            try {
                for(MultipartFile file : files) {
                    File temp = new File(uploadPath, file.getOriginalFilename());
                    file.transferTo(temp);
                    
                    AttachmentDTO attachmentDTO = new AttachmentDTO();
                    attachmentDTO.setNoticeId(noticeDTO.getId());
                    attachmentDTO.setPath(temp.getName());
                    
                    attachedList.add(attachmentDTO);
                }
                ATTACHMENT_SERVICE.insert(attachedList);
                
            } catch (IllegalStateException | IOException e) {
                e.printStackTrace();
            }
            if (authentication != null) {
                EmployeeDTO logIn = (EmployeeDTO) authentication.getPrincipal();

                model.addAttribute("logInusername", logIn.getUsername());
                model.addAttribute("logInname", logIn.getName());
                model.addAttribute("logIngrade", logIn.getGrade());
                model.addAttribute("logInteamcode", logIn.getTeamCode());
                model.addAttribute("logInteamname", logIn.getTeamName());
            }
            return "redirect:/main";
        }
    
    
    
    // 공지사항삭제
    @GetMapping("deleteNotice/{id}")
    public String delete(Authentication authentication, @PathVariable int id) {

        NoticeDTO noticeDTO = NOTICE_SERVICE.selectOne(id);

        if (noticeDTO == null) {
            return "redirect:/main";
        }

        NOTICE_SERVICE.delete(id);

        return "redirect:/main";
    }

    // 공지사항수정
    @PostMapping("updateNotice/{id}")
    public String updateNotice(@PathVariable int id, NoticeDTO noticeDTO) {
        noticeDTO.setId(id);
        NOTICE_SERVICE.update(noticeDTO);
        return "redirect:/main";
    }
}
