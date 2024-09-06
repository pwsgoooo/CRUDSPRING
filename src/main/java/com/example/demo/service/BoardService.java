package com.example.demo.service;

import com.example.demo.dto.BoardCommentDto;
import com.example.demo.dto.BoardDto;
import com.example.demo.mapper.BoardMapper;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.el.stream.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


@Service
public class BoardService {

    private final BoardMapper boardMapper;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    BoardService(BoardMapper boardMapper) {
        this.boardMapper = boardMapper;
    }

    @Transactional
    public List<BoardDto> printBoardList_i(Long offset) {
        return boardMapper.printBoardList_i(offset);
    }


  @Transactional
    public List<BoardDto> printActBoards(Long offset) {
        return boardMapper.printActBoards(offset);
    }

    @Transactional
    public List<BoardDto> printActBoards_(Long offset) {
        List<BoardDto> boards = boardMapper.printActBoards(offset);
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        //LocalDateTime now = LocalDateTime.now();

        return boards.stream().map(board -> {
            BoardDto dto = new BoardDto();
            dto.setId(board.getId());
            dto.setTitle(board.getTitle());
            dto.setRegDate(board.getRegDate());
            dto.setRegIp(board.getRegIp());
            dto.setRegMember(board.getRegMember());
            dto.setDipdate(board.getRegIp());

            DateTimeFormatter formatter;
            if (board.getRegDate().toLocalDateTime().toLocalDate().isEqual(timestamp.toLocalDateTime().toLocalDate())) {
                formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
            } else {
                formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            }
            dto.setDipdate(board.getRegDate().toLocalDateTime().format(formatter));

            return dto;
        }).collect(Collectors.toList());
    }




    @Transactional
    public Long cntLists(){
        return boardMapper.cntLists();
    }



    public List<BoardDto> searchBoardLists(String searching,String sccon) {
        List<BoardDto> returnlist = new ArrayList<>();

        if ("작성자".equals(searching)){
            returnlist =  boardMapper.searchBoardLists_mem(sccon);
        } else if ("제목".equals(searching)) {
            returnlist = boardMapper.searchBoardLists_title(sccon);
        }else if("작성일".equals(searching)){
            returnlist = boardMapper.searchBoardLists_date(sccon);
        } //else로 전체 리스트 조회하는 방법 고려안해도 될듯:제목 텍스트 클릭시 맨 첫화면으로 감
        return returnlist;

    }

    @Transactional
    public List<BoardDto> printBoardList() {
        List<BoardDto> list;
        list = boardMapper.printBoardList();
        return list;
    }


    @Transactional
    public BoardDto printBoardById(Long id) {
        BoardDto board = boardMapper.printBoardById(id);
        return board;
    }

    @Transactional
    public BoardCommentDto printComment(Long id) {
        BoardCommentDto comment = boardMapper.printComment(id);
        return comment;
    }

    @Transactional
    public List<BoardCommentDto> printComments(Long id) {
        List<BoardCommentDto> board = boardMapper.printComments(id);
        return board;
    }

    @Transactional
    public void updateBoard(Long id, String title, String content) {

        BoardDto updtBoard = boardMapper.printBoardById(id);
        Timestamp modDate = new Timestamp(System.currentTimeMillis());
        String clientIp = request.getLocalAddr();
        String modMember = "anonymous";

        updtBoard.setId(id);
        updtBoard.setTitle(title);
        updtBoard.setContent(content);
        updtBoard.setModIp(clientIp);
        updtBoard.setModDate(modDate);
        updtBoard.setModMember(modMember);
        boardMapper.updateBoard(updtBoard);
    }

    @Transactional
    public void softDelBoard(Long id) {
        BoardDto softDelBoard = boardMapper.printBoardById(id);
        Timestamp delDate = new Timestamp(System.currentTimeMillis());
        String clientIp = request.getLocalAddr();
        String delMember = "anonymous"; //session cookie에서 로긴 유저 가져오기

        softDelBoard.setId(id);
        softDelBoard.setTitle(softDelBoard.getTitle());
        softDelBoard.setModDate(softDelBoard.getModDate());
        softDelBoard.setModIp(softDelBoard.getModIp());
        softDelBoard.setModMember(softDelBoard.getModMember());
        softDelBoard.setDelDate(delDate);
        softDelBoard.setDelIp(clientIp);
        softDelBoard.setDelMember(delMember);

        boardMapper.softDelBoard(softDelBoard);

    }

    @Transactional
    public void registerBoard(String title, String content) throws IOException {
        Timestamp regDate = new Timestamp(System.currentTimeMillis());
        String clientIp = request.getLocalAddr();
        BoardDto boardDto = new BoardDto();

        boardDto.setTitle(title);
        boardDto.setContent(content);
        boardDto.setRegDate(regDate);
        boardDto.setRegIp(clientIp);
        boardDto.setRegMember("anonymous");
        boardMapper.registerBoard(boardDto);
    }

    @Transactional
    public void registerdat(Long id, String inputdt) throws IOException {
        try{
            Timestamp regDate = new Timestamp(System.currentTimeMillis());
            String clientIp = request.getLocalAddr();
            BoardCommentDto boardCommentDto = new BoardCommentDto();
            String member = "anonymous"; //session cookie에서 로긴 유저 가져오기

            boardCommentDto.setParentId(0L);
            boardCommentDto.setBoardId(id);
            boardCommentDto.setComment(inputdt);
            boardCommentDto.setRegDate(regDate);
            boardCommentDto.setRegIp(clientIp);
            boardCommentDto.setRegMember(member);

            boardMapper.registerdat(boardCommentDto);
        } catch (Exception e) {
            throw new IOException(e);
        }

    }

    @Transactional
    public void updatedat(Long id, String inputdt) {
        BoardCommentDto updat = boardMapper.printComment(id);
        Timestamp modDate = new Timestamp(System.currentTimeMillis());
        String clientIp = request.getLocalAddr();
        String modMember = "anonymous";

        updat.setId(id);
        updat.setComment(inputdt);
        updat.setModDate(modDate);
        updat.setModIp(clientIp);
        updat.setModMember(modMember);
        boardMapper.updatedat(updat);
    }

    @Transactional
    public void softDeldat(Long id) {
        BoardCommentDto softDeldat = boardMapper.printComment(id);
        Timestamp delDate = new Timestamp(System.currentTimeMillis());
        String clientIp = request.getLocalAddr();
        String delMember = "anonymous";

        softDeldat.setId(id);
        softDeldat.setModIp(clientIp);
        softDeldat.setModDate(delDate);
        softDeldat.setModMember(delMember);
        boardMapper.softDeldat(softDeldat);
    }

    @Transactional
    public List<BoardDto> consearch(Long offset) {
        return boardMapper.consearch(offset);
    }

}



