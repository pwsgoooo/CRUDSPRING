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
            margin-top: -5px;
            color:#333;
            font-weight: 800;
        }

        div.writedt p.inb{margin-top:-20px;}

        /*.dt {*/
        /*    margin-left:5%;*/
        /*    width:90%;*/
        /*}*/

        .btnlist{
            display: inline-flex;
        }
    </style>
</head>
<body>
<div class="container">
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
    <script>
        const updateurl = "/detailviewbyidupdate"+parseInt(${detail.id});

    </script>

    <script>

        window.onload= function (){
            const cntdat = document.getElementById("inputdt");
            const printpos = document.getElementById("printpos");
            cntdat.addEventListener('input',function(){
                let num = cntdat.value.length;
                printpos.textContent=num;
            });
        }

        function toupdate(){
            if(confirm("게시글 수정 페이지로 이동합니다.")){
            <%--const updateurl = "/detailviewbyidupdate/"+parseInt(${detail.id});--%>
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
                window.history.back();
            }
        }
    </script>


    <hr style="margin:3% 0;">

    <p class="bold"><span>&nbsp;&nbsp;&nbsp;&nbsp;</span><c:out value="${upcomm.regMember}"/><span id="nn" class="fred ">&nbsp; 0 &nbsp;</span><span>분전</span></p>
    <div class="dt" style="height: 130px;">
        <form action="" method="post">
            <input type="text" name="updat" id="updat"/>
            <input type="submit" name="submitupdat" id="submitupdat" class="btn"/>
        </form>
    </div>
    <hr style="margin:3% 0;">


    <c:choose>
        <c:when test="${not empty comments}">
            <c:forEach items="${comments}" var="comment">
            <c:if test="${comments.id ne upcomm.id}">
                <p class="bold"><span>&nbsp;&nbsp;&nbsp;&nbsp;</span><c:out value="${comment.regMember}"/><span id="nn" class="fred ">&nbsp; 0 &nbsp;</span><span>분전</span></p>
                <div class="dt" style="height: 130px;">
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