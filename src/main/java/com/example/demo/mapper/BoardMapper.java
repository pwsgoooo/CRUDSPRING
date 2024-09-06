package com.example.demo.mapper;

import com.example.demo.dto.BoardCommentDto;
import com.example.demo.dto.BoardDto;
import com.example.demo.dto.Condition;
import com.example.demo.dto.DetailViewPageDto;
import org.apache.el.stream.Optional;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.Timestamp;
import java.util.List;
//import com.example.demo.dto.BoardCommentDto;
//import org.apache.ibatis.annotations.ResultMap;
//import org.springframework.web.multipart.MultipartFile;

//import java.util.ArrayList;
//
// import java.util.Map;

@Mapper
public interface BoardMapper {

    List<BoardDto> consearch(Long offset);

    List<BoardDto> printBoardList_i(Long offset);

    List<BoardDto> printActBoards(Long offset);

    Long cntLists();


    List<BoardDto> searchBoardLists_mem(String sccon);
    List<BoardDto> searchBoardLists_title(String sccon);
    List<BoardDto> searchBoardLists_date(String sccon);

    List<BoardDto> printBoardList();

    BoardDto printBoardById(Long id);
    List<BoardCommentDto> printComments(Long id);
    BoardCommentDto printComment(Long id);

    void registerBoard(BoardDto boardDto);

    void registerdat(BoardCommentDto boardCommentDto);

    void updateBoard(BoardDto boardDto);


    void softDelBoard(BoardDto boardDto);

    void updatedat(BoardCommentDto boardCommentDto);

    void softDeldat(BoardCommentDto boardCommentDto);



}
