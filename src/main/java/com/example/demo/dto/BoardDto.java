package com.example.demo.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class BoardDto{

    private Long id;
//기본생성자
    public BoardDto(){   
    }
    private String title;
    private String content;
    private Timestamp regDate;
    private String regIp;
    private String regMember;
    private Timestamp modDate;
    private String modIp;
    private String modMember;
    private Timestamp delDate;
    private String delIp;
    private String delMember;

    private String dipdate;
    private Long limit;
    private Long offset;
    private Long nowPage;
}
