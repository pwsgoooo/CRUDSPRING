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


    List<BoardDto> searchBoardLists_(Condition condition);

    BoardDto printBoardById(Long id);
    List<BoardCommentDto> printComments(Long id);

    List<BoardCommentDto> printComments_forupdate(Long id);
    BoardCommentDto printComment(Long id);

    void registerBoard(BoardDto boardDto);

    void registerdat(BoardCommentDto boardCommentDto);

    void updateBoard(BoardDto boardDto);


    void softDelBoard(BoardDto boardDto);

    void updatedat(BoardCommentDto boardCommentDto);

    void softDeldat(BoardCommentDto boardCommentDto);



}