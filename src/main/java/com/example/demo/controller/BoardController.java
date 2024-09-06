package com.example.demo.controller;

import com.example.demo.dto.BoardCommentDto;
import com.example.demo.dto.BoardDto;
import com.example.demo.mapper.BoardMapper;
import com.example.demo.service.BoardService;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/")
@Log4j2
public class BoardController {

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

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
//        model.addAttribute("list2", list2);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("nowPage", nowPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("currcnt", currcnt);

        return "board";
    }

//    조건검색부 출력
    @GetMapping("/consearch")
    public String consearch(@RequestParam("searching") String searching,
                            @RequestParam("sccon") String sccon,
                            @RequestParam(name = "page", defaultValue = "0") long offset,
                            @RequestParam(name="page", defaultValue = "1") long nowPage,
                            Model model){
        List<BoardDto> list = boardService.searchBoardLists(searching,sccon); //offset
        model.addAttribute("list",list);

        long totalCount = list.size();
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


//    @PostMapping("/updateboard/{id}")
//    @GetMapping("/updateboard/{id}")
//    public String updateboard(@PathVariable("id") Long id, @RequestParam("title") String title,@RequestParam("content") String content ) throws IOException {
//        try {
//            boardService.updateBoard(id, title, content);
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//        return "/detailviewbyid/"+id;
//    }

    @PostMapping("/updateboard/{id}")
    public String updateboard(@PathVariable Long id, @RequestParam("title") String title, @RequestParam("content") String content){
        boardService.updateBoard(id, title, content);
        return "redirect:/board";
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
//댓글 수정 삭제

    // pid : 본 게시글 id, id : 해당 pid의 댓글 id
    @PostMapping("/updatedatp/{pid}/{id}")
    public String toupdatedat(@PathVariable("pid") Long pid,@PathVariable("id") Long id, Model model){
        BoardDto detail = boardService.printBoardById(pid);
       // boardService.updatedat(id, updat);

        List<BoardCommentDto> comments = boardService.printComments(pid);
        BoardCommentDto upcomm = boardService.printComment(id);

        model.addAttribute("detail",detail);
        model.addAttribute("comments",comments);
        model.addAttribute("upcomm",upcomm);
        return "detailviewbyidinsertdat";
    }


    @PostMapping("/updatedat/{pid}/{id}")
    public String updatedat(@PathVariable("pid") Long pid,@PathVariable("id") Long id, @PathVariable("updat") String updat, Model model){
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
            return "redirect:/board";
        }
    }


    @GetMapping("/test")
    public String test(){
        return "test";
    }

    @GetMapping("/test2")
    public String test2(Model model){
        List<BoardDto> list = boardService.printBoardList();
        model.addAttribute("list", list);
         System.out.println(list);
        return "test2";
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

