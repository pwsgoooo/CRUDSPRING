package com.example.demo.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.w3c.dom.Text;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Data
public class BoardFileDto {

    private UUID fileUuid;
    public BoardFileDto(){
        this.fileUuid = UUID.randomUUID();
    }

    private Long boardId;
    private String name;
    private String mimeType;
    private Timestamp regDate;
    private String regIp;
    private String regMember;

}


