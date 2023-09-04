package com.bit.model;

import java.sql.Date;

import lombok.Data;

@Data
public class AllPaymentDTO {
 
    private int id;  // 납입내역구분번호
    private int number; // 증서번호
    
    private String depositor;  // 예금주
    private String bank; // 은행
    private int account;  // 계좌
    private String teamName;  // 처리자부서명
    private String name;  // 처리자이름
    private String username;  // 처리자사번
    private String ssn;  // 주민등록번호
    
    // 추가(이너조인관련)
    private String productName;  // 상품명
    private String contractor; // 계약자
    private int premium;  // 보험료
    private String status;  // 계약상태명(정상, 실효)
    private Date finalDate;  // 종납년월
    
    private String paymentMethod;  // 납입방법(즉시출금, 자동이체)
    private String paymentStatus; // 납입상태명(정상, 반송)
    private Date paidDate; // 납입년월
    private int count;  // 납입횟수
    private Date processDate; // 처리일자

 // 입력받은 날짜 문자열을 Date 객체로 변환하여 저장하기 위한 임시 변수
    private String startDate; // 시작일자
    private String endDate; // 종료일자
    
 // 대시보드
    private int paymentCount;  // 처리건수
    private String month;  // 월 구분
}
