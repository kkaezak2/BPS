package com.bit.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.bit.model.AlarmDTO;
import com.bit.service.AlarmService;

public class AlarmHandler extends TextWebSocketHandler {

    private AlarmService ALARM_SERVICE;
  
    // 로그인 한 인원 전체
    private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();

    @Autowired
    public AlarmHandler(AlarmService alarmService) {
        this.ALARM_SERVICE = alarmService;
    }

    // 클라이언트가 웹 소켓 생성
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
        }


    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

       for (WebSocketSession single : sessions) {
          // 세션아이디
          single.sendMessage(new TextMessage(message.getPayload()));
          String sessionId = message.getPayload();
          
          String username = session.getPrincipal().getName();
          // 세션값이 같을때, 알람보낼 것이 있을 때만 전송 -> 로그인 한 사용자가 처음으로 알람 받는 순간임
          // 해당 sendMsg에 DB정보 넣어서 체크 안된 알람 전부 전송하기

          List<AlarmDTO> dto = new ArrayList<>();
          dto = ALARM_SERVICE.selectAlarm(username);
          
          for (AlarmDTO alarm : dto) {
             
             String code = alarm.getCode();
             int applyNumber = alarm.getApplyNumber();
             String senderId = alarm.getUsername();
             String receiverId = alarm.getReceiver();

             if (username.equals(sessionId) && username.equals(senderId)) {
                
                code = "<i class=\"fas fa-fw fa-bell\" id=\"alarmI\" style=\"color:white;\"></i>&nbsp;"
                      + "[알림]신청번호&nbsp;" + applyNumber + "의 결재 요청이 도착했습니다.";

                // Create a JSON object to include the message and applyNumber
                ObjectMapper objectMapper = new ObjectMapper();
                Map<String, Object> customData = new HashMap<>();
                customData.put("message", code);
                customData.put("applyNum", applyNumber);
                customData.put("senderId", senderId);
                customData.put("receiverId", receiverId);
                customData.put("username", username);
                
                String jsonCustomData = objectMapper.writeValueAsString(customData);

                TextMessage sendMsg = new TextMessage(jsonCustomData);

                single.sendMessage(sendMsg);
             }
          }
       }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {// 연결 해제
        // TODO Auto-generated method stub
        // logger.info("Socket 끊음");
        // 웹 소켓이 종료될 때마다 리스트에서 뺀다.
        sessions.remove(session);
    }
}