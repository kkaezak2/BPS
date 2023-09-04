package com.bit.model;

import lombok.Data;

@Data
public class ScheduleDTO {
    private int id;  // 스케쥴고유번호
    private String writerId;  // 스케쥴작성자id(=username)
    private String title;  // 스케쥴제목
    private String start;  // 스케쥴시작일자
    private String end;  // 스케쥴종료일자
}
