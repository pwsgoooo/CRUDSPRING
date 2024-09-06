package com.example.demo.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;
import java.util.UUID;

@Data
public class MemberDto {
    private String userId;
    private String userPw;
    private String name;
    private String phone;
    private String email;
    private String stat;
    private Timestamp regDate;
    private String regIp;
    private String regMember;
    private Timestamp modDate ;
    private String modIp;
    private String modMember;
    private String office;
    private String depart;
}
