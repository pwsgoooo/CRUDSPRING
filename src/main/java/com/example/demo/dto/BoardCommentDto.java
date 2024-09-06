package com.example.demo.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.w3c.dom.Text;

import java.sql.Timestamp;

@Data
public class BoardCommentDto {
    private Long id;
    private Long parentId;
    private Long boardId;
    private String comment;
    private Timestamp regDate;
    private String regIp;
    private String regMember;
    private Timestamp modDate;
    private String modIp;
    private String modMember;
    private Timestamp delDate;
    private String delIp;
    private String delMember;
}
