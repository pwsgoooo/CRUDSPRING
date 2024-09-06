package com.example.demo.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Data
public class Comments {
    private Long commentId;
    private String comment;
    private Long commentParentId;
    private Timestamp commentRegDate;
    private String member;
    private String commentRegIp;
    private Timestamp commentModDate;
    private String commentModIp;
    private String commentMember;
}
