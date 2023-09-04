package com.bit.model;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class RefundDTO {
    private int id; // 반송구분번호
    // 순정추가
    private int applyNumber; // 승인번호

    private int allPaymentId; // 납입내역ID
    private Timestamp processDate; // 처리일자
    private String username; // 처리자사번
    private String name; // 처리자
    private String teamName; // 부서명
    private String status; // 상태
    private String username2; // 승인자사번
    private String approver; // 승인자
    private Timestamp approvalDate; // 승인일자

    // 이너조인 추가
    private int number; // 넘버
    private Date paidDate; // 납입년월
    private int count; // 회차
    private String productName; // 상품명
    private String contractor; // 계약자
    private int premium; // 보험료
}
