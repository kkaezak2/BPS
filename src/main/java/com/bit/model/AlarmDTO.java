package com.bit.model;

import lombok.Data;
import java.sql.Timestamp;
import java.util.List;

@Data
public class AlarmDTO {

    private int id; // 알람고유id
    private Timestamp date; // 알람시간
    private String approver; // 결재자
    private int checked; // default 1
    private String code; // 알림전달코드
    private String prefix; 
    private int applyNumber; // 반송신청번호
    private String receiver; // 결재자id
    private String username; // 요청자 id
    private String name; // 요청자 이름
}
