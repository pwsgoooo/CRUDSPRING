package com.example.demo.controller;

import com.example.demo.dto.BoardCommentDto;
import com.example.demo.dto.BoardDto;
import com.example.demo.dto.Condition;
import com.example.demo.mapper.BoardMapper;
import com.example.demo.service.BoardService;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/")
@Log4j2
public class BoardController {

    private final BoardService boardService;

    @Autowired
    public BoardController(BoardService boardService){
        this.boardService = boardService;
    }

    @GetMapping("/board")
    public String gethome(@RequestParam(name = "page", defaultValue = "0") long offset, @RequestParam(name="page", defaultValue = "1") long nowPage, Model model) {
        List<BoardDto> list = boardService.printActBoards_(offset);

        long totalCount = boardService.cntLists();
        long totalPages = (totalCount + 20 - 1) / 20;
        long startPage = Math.max(nowPage - 4, 1);
        long endPage = Math.min(nowPage + 4, totalPages);
        long currcnt = (nowPage<totalPages) ? 20 : totalCount%20;

        model.addAttribute("list", list);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("nowPage", nowPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("currcnt", currcnt);

        return "board";
    }




// 조건부 검색을 위한 서비스 처리 (참고)
//    @Transactional
//    public List<BoardDto> searchBoardLists_(Condition condition){
//        int offset = (condition.getPage()-1)*condition.getSize();
//        condition.setPage(offset);
//        condition.setSize(20);
//        return boardMapper.searchBoardLists_(condition);
//    }

    @RequestMapping(value="/consearch", method=RequestMethod.POST, consumes="application/x-www-form-urlencoded;")
    public ResponseEntity<List<BoardDto>> searchBoardLists_(@RequestBody @Validated Condition condition,@RequestParam(name = "page", defaultValue = "0") long offset,
                            @RequestParam(name="page", defaultValue = "1") long nowPage,
                            Model model) {
        List<BoardDto> conditionboards = boardService.searchBoardLists_(condition);

        model.addAttribute("list", conditionboards);
//        model.addAttribute("totalCount", totalCount);
//        model.addAttribute("totalPages", totalPages);
        model.addAttribute("nowPage", nowPage);
//        model.addAttribute("startPage", startPage);
//        model.addAttribute("endPage", endPage);
//        model.addAttribute("currcnt", currcnt);
        return ResponseEntity.ok(conditionboards); // List<BoardDto>를 ResponseEntity로 반환
    }

//    //    조건검색부 출력
//    @GetMapping("/consearch")
//    public String consearch(@RequestParam("searching") String searching,
//                            @RequestParam("sccon") String sccon,
//                            @RequestParam(name = "page", defaultValue = "0") long offset,
//                            @RequestParam(name="page", defaultValue = "1") long nowPage,
//                            Model model){
//        List<BoardDto> list = boardService.searchBoardLists(searching,sccon); //offset
//        model.addAttribute("list",list);
//
//        long totalCount = list.size();
//        long totalPages = (totalCount + 20 - 1) / 20;
//        long startPage = Math.max(nowPage - 4, 1);
//        long endPage = Math.min(nowPage + 4, totalPages);
//        long currcnt = (nowPage<totalPages) ? 20 : totalCount%20;
//
//        model.addAttribute("list", list);
//        model.addAttribute("totalCount", totalCount);
//        model.addAttribute("totalPages", totalPages);
//        model.addAttribute("nowPage", nowPage);
//        model.addAttribute("startPage", startPage);
//        model.addAttribute("endPage", endPage);
//        model.addAttribute("currcnt", currcnt);
//
//        return "board";
//    }


    @GetMapping("/insert")
    public String insert(){
        return "insert";
    }

    @PostMapping("/register")
    public String register(@RequestParam("title") String title, @RequestParam("content") String content, Model model) throws IOException {
        try{
            boardService.registerBoard(title, content);
        }catch( IOException e){
            throw new IOException(e);

        }
        return "redirect:/board";
    }


    @GetMapping("/detailviewbyid/{id}")
    public String viewrow(@PathVariable("id") Long id, Model model) throws IOException{
        try{
            BoardDto detail = boardService.printBoardById(id);
            model.addAttribute("detail", detail);
            System.out.println(detail);

            List<BoardCommentDto> comments = boardService.printComments(id);
            model.addAttribute("comments",comments);

        } catch (Exception e) {
            throw new IOException(e);
        }


            return "detailviewbyid";
    }

    @GetMapping("/detailviewbyidupdate/{id}")
    public String toupdate(@PathVariable("id") Long id, Model model) throws IOException {
        try {
            BoardDto detail = boardService.printBoardById(id);
            List<BoardCommentDto> comments = boardService.printComments(id);
            model.addAttribute("comments",comments);
            model.addAttribute("detail", detail);

        } catch (Exception e) {
            throw new IOException(e);
        }
        return "detailviewbyidupdate";
    }


    @PostMapping("/registerdat/{id}")
    public String regisdat(@PathVariable("id") Long id, @RequestParam("inputdt") String inputdt) throws IOException {
        try {
            boardService.registerdat(id, inputdt);
        } catch (Exception e) {
            throw new IOException(e);
        }
        return "redirect:/detailviewbyid/"+id;
    }

    @PostMapping("/updateboard/{id}")
    public String updateboard(@PathVariable Long id, @RequestParam("title") String title, @RequestParam("content") String content){
        boardService.updateBoard(id, title, content);
        return "redirect:/detailviewbyid/"+id;
    }

    @GetMapping("/delboard/{id}")
    public String doDelete(@PathVariable("id") Long id) throws IOException{
        try{
            boardService.softDelBoard(id);




        } catch (Exception e) {
            throw new IOException(e);
        }
        finally {
            return "redirect:/board";
        }
    }


    // pid : 본 게시글 id, id : 해당 pid의 댓글 id
    @GetMapping("/updatedatp/{id}")
    public String toupdatedat(@PathVariable("id") Long id,Model model){
        BoardCommentDto upcomm = boardService.printComment(id);
        model.addAttribute("upcomm",upcomm);
        BoardDto detail = boardService.printBoardById(upcomm.getBoardId());
        model.addAttribute("detail",detail);

        List<BoardCommentDto> exupcomm = boardService.printComments_forupdate(id);
        model.addAttribute("exupcomm",exupcomm);


        return "/detailviewbyidupdatedat";
    }


    @PostMapping("/updatedat/{id}")
    public String updatedat(@PathVariable("id") Long id, @RequestParam("updat") String updat, Model model){
        BoardCommentDto comment = boardService.printComment(id);
        Long pid =comment.getBoardId();
        boardService.updatedat(id, updat);
        return "redirect:/detailviewbyid/"+pid;
    }

    @GetMapping("/updeldat/{pid}/{id}")
    public String updeldat(@PathVariable("pid") Long pid,@PathVariable("id") Long id, Model model){
        try{
            boardService.softDeldat(id);
        } catch (Exception e) {
            throw new IOException(e);
        }
        finally {
            return "redirect:/detailviewbyid/"+pid;
        }
    }
}

//   print! all board rows !success
//    @GetMapping("/board")
//    public String gethome(@RequestParam(name = "page", defaultValue = "0") long offset, @RequestParam(name="page", defaultValue = "1") long nowPage, Model model) {
//        List<BoardDto> list = boardService.printBoardList_i(offset);
//
//
//
//        long totalCount = boardService.cntLists();
//        long totalPages = (totalCount + 20 - 1) / 20;
//        long startPage = Math.max(nowPage - 4, 1);
//        long endPage = Math.min(nowPage + 4, totalPages);
//        long currcnt = (nowPage<totalPages) ? 20 : totalCount%20;
//
//        model.addAttribute("list", list);
//        model.addAttribute("totalCount", totalCount);
//        model.addAttribute("totalPages", totalPages);
//        model.addAttribute("nowPage", nowPage);
//        model.addAttribute("startPage", startPage);
//        model.addAttribute("endPage", endPage);
//        model.addAttribute("currcnt", currcnt);
//
//        return "board";
//    }

