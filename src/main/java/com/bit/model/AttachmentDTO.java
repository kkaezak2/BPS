package com.bit.model;

import lombok.Data;

@Data
public class AttachmentDTO {
    private int id;  // 첨부고유id
    private int noticeId;  // 공지글고유번호
    private String path;  // 경로
}
