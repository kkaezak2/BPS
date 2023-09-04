package com.bit.model;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class ContractDTO {
    private int number;  // 증서번호
    private int productCode;  // 상품코드
    private String productName;  // 상품명
    private String contractor;  // 계약자이름
    private String ssn;  // 계약자주민등록번호
    private int premium;  // 보험료
    private Date date;  // 계약일자
    private String paymentMethod;  // 납입방법
    private String status;  // 계약상태명(정상, 실효)
    private Date finalDate;  // 종납년월
    private int count;  // 납입횟수
    
    //이너조인 추가
    private String accountDate;              // 자동이체일자
    private String bank;                     // 은행명
    private int account;                     // 계좌번호
    private Timestamp  modifyDate;           //변경일자
    private String depositor;                // 예금주이름
    private String accountOption;            // 신청구분-등록,해지
}