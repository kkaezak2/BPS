package com.bit.model;

import lombok.Data;

@Data
public class CustomerDTO {
    private int id;  // 고객구분번호, AC
    private String name; // 고객명
    private String ssn; // 고객주민등록번호
    private String mobile; // 고객핸드폰
    private String addr1; // 고객주소1
    private String addr2;  // 고객주소2
}
