package com.bit.model;

import java.sql.Timestamp;
import java.util.Collections;
import java.util.List;

import lombok.Data;

@Data
public class AutoPaymentDTO {
    private int id;                          // 자동내역구분번호
    private int number;                      // 증서번호
    private String ssn;                      // 고객주민등록번호
    private String paymentMethod;            // 납입방법
    private String accountDate;              // 자동이체일자
    private String depositor;                // 예금주이름
    private String bank;                     // 은행명
    private int account;                     // 계좌번호
    private String accountOption;            // 신청구분-등록,해지
    private Timestamp  modifyDate;            // 변경일자_7.26타입변경
    
 // 'list' 속성에 대한 getter 메서드 추가
    public List<AutoPaymentDTO> getList() {
        return Collections.singletonList(this);
    }
}
