<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>detailviewById</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        html,body{
            margin:0;
            padding: 0;
            background-color: #333333;
            color:white;
        }
        .dat{
            width:80%;
            height:120px;
            margin-top:-20px;
        }

        input::placeholder{color:#333;}
        textarea::placeholder{color:#333;}

        .container{
            width:70%;
            margin: 0 auto;

        }

        .w100{
            width:100%;
            padding:7px;
        }
        #title{
            margin-bottom: 4px;
        }
        #content{
            height:300px;
        }

        div.container table.w100 td {
            width:33%;
            height: 40px;
        }
        .btn{
            width: 120px;
            height: 30px;
            border: 0;
            border-radius: 3px;
            color:white;
            font-weight: bold;
        }
        .btn:hover{
            cursor: pointer;
        }
        .right02 {
            width:50px;
            position:absolute;
            left:82%;
            margin-top: -38px;
        }

        .bold {
            font-weight: 600;
        }

        .fred {
            color:#FF5959;
        }

        .fblue {
            color:#14AAFF;
        }

        .bggreen{
            background-color: #4FD86D;
        }
        .bglighblue{
            background-color: #14AAFF;
        }
        .bgred{
            background-color: #FF5959;
        }
        .bggray{
            background-color: #CCCCCC;
        }
        .bglightgrey{
            background-color:#F6F6F6;
        }
        #files{
            display: inline-block;
        }

        #bottbtnlist{
            width:100%;
            padding: 5% 39%;
        }

        .writedt {
            width: 95%;
            height: 120px;
            padding: 3%;
            border:1px solid black;
        }

        div.writedt p {
            margin-top: -15px;
            color:#333;
            font-weight: 800;
        }

        div.writedt p.inb{margin-top:-4px;}

        .btnlist{
            display: inline-flex;
        }

        div.dt{
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="container">


    <div style="z-index: 50;width:50px; height: 50px; position:absolute; top:43%; left: 20px;">
        <a href="/board">
            <img style="height: 50px; width:50px;" src="data:image/png;base64,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" alt="">
        </a>
    </div>


    <div style="margin-top:30px;">
        <h3 style="display: inline-block; width:55%;">게시판 상세</h3>
        <div style="display: inline-block;width:44%; text-align: right;">
            작성자: ${detail.regMember} <br/>
            작성 일자: ${detail.regDate} <br/>
            마지막 업데이트 일자: ${detail.modDate} <br/>
        </div>
    </div>
    <div class="w100" type="text" name="title" id="title"><c:out value="${detail.title}"/></div>
<%--    <br/>--%>
    <div class="w100" style="border:1px solid navajowhite; padding-top:50px;box-sizing: border-box;" name="content" id="content">
        <c:out value="${detail.content}"/>
    </div>
    <div id="bottbtnlist">
        <button onclick="toupdate();" class="btn bglighblue">수정</button>
        <button onclick="tolist();" class="btn bggray">목록</button>
    </div>

    <script>
        window.onload= function (){
            const cntdat = document.getElementById("inputdt");
            const printpos = document.getElementById("printpos");
            cntdat.addEventListener('input',function(){
                let num = cntdat.value.length;
                if(num>=200){
                    alert("댓글 최대입력 글자수는 200입니다.");
                }
                printpos.textContent=num;
            });
        }

        function toupdate(){
            if(confirm("게시글 수정 페이지로 이동합니다.")){
                const updateurl = "/detailviewbyidupdate/"+parseInt(${detail.id});
                window.location.href= updateurl;
            }else{
                alert("게시판 상세 페이지에 머무릅니다.");
                window.location.href="/detailviewbyid/"+parseInt(${detail.id});
            }

        }
        function tolist(){
            alert("목록으로 돌아갑니다.");
            window.location.href="/board";
        }

        function softDel(pid, id){
            if(confirm("선택한 댓글을 삭제하시겠습니까?")){
                alert("댓글을 삭제합니다.");
                window.location.href="/updeldat/"+pid+"/"+id;

            }
        }
        function registerdat(){
            const inputdt = document.getElementById("inputdt").value;
            const url = "/registerdat/"+parseInt(${detail.id});
            if(confirm("댓글을 등록합니다.")){
                $.ajax({
                    url: url,
                    type: "POST",
                    data:{
                        "inputdt":inputdt
                    },
                    success: function(){
                        alert("댓글 등록이 완료되었습니다.");
                        window.location.href="/detailviewbyid/"+parseInt("${detail.id}");
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        alert("오류가 발생했습니다: " + textStatus);
                    }
                });
            } else {
                alert("이전화면으로 돌아갑니다.");
                return false;
                // window.history.back();
            }
        }
    </script>

    <div class="writedt bglightgrey">
        <p> 댓글 쓰기</p>
        <input class="dat" type="text" name="inputdt" id="inputdt" maxlength="200" placeholder="답글을 작성해주세요. 최대 200자까지 작성할 수 있습니다."/>+content.replace("\r\n","<br/>")
        <p class=" inb"> <span id="printpos"> 0 </span> / 200</p>
        <button onclick="registerdat();" type="submit" class="inb btn bggreen right02">등록</button>
    </div>
    <hr style="margin:3% 0;">




    <c:choose>
        <c:when test="${not empty comments}">
            <c:forEach items="${comments}" var="comment">
                <p class="bold"><span>&nbsp;&nbsp;&nbsp;&nbsp;</span><c:out value="${comment.regMember}"/>
                    <span id="nn" class="fred ">&nbsp;
                        <c:choose>
                            <c:when test="${not empty comment.modDate}">
                                <c:out value="${comment.modDate}"/>
                            </c:when>
                            <c:otherwise>
                                <c:out value="${comment.regDate}"/>
                            </c:otherwise>
                        </c:choose>
                    </span></p>
                <div class="dt" style="height: 130px;">
                    <ul style="float:right;margin-top: -20px;color:white; list-style: none; font-size:0.9em;display:inline-flex">
                        <button onclick="window.location.href='/updatedatp/${comment.id}'" style="display: inline-block; cursor: pointer;" class="fred" >
                            수정&nbsp;
                        </button>|
<%--                        <button onclick="window.location.href='/updeldat/${detail.id}/${comment.id}'" style="display: inline-block; cursor: pointer;" class="fblue" >--%>
                        <button onclick="softDel(${detail.id},${comment.id})" style="display: inline-block; cursor: pointer;" class="fblue" >
                            &nbsp;삭제
                        </button>
                    </ul>
                    <br/>
                    <p><c:out value="${comment.comment}"/></p>
                    <p>댓글의 id : <c:out value="${comment.id}"/></p>
                </div>
                <hr style="margin:3% 0;">
            </c:forEach>

        </c:when>
        <c:otherwise>
            <p style="padding:30px;"> 댓글이 없습니다. </p>
            <hr style="margin:3% 0;">
        </c:otherwise>

    </c:choose>

</body>
</html>