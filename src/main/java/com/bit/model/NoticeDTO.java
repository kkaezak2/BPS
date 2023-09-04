package com.bit.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeDTO {
    private int id;  // 공지글고유번호
    private String writerId;  // 작성자id(=username)
    private String writer;  // 작성자(=name)
    private String title;  // 제목
    private String content;  // 내용
    private Timestamp entryDate;  // 작성일자
    private Timestamp modifyDate; // 수정일자
}
