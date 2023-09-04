package com.bit.model;

import lombok.Data;

@Data
public class AccountDTO {
    private int id;                    // 계좌구분번호
    private int account;               // 계좌번호
    private String ssn;                // 계약자주민등록번호
    private String bank;               // 은행명
    private String depositor;          // 예금주이름
    private String depositorSsn;       // 예금주주민등록번호
}
