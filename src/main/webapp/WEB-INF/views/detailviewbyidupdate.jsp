<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> !!! let's update ggya > _ < !!! </title>

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
        #attfile{
            display: inline-block;
        }

        #bottbtnlist{
            width:100%;
            padding: 5% 39%;
        }

        .writedt {
            width: 100%;
            height: 220px;
            padding: 4%;
            border:1px solid black;
        }

        div.writedt input#inputdt{
            width:95%;
            height:150px;
            margin-left: 15px;
        }

        .dt {
            margin-left:5%;
        }

        .btnlist{
            display: inline-flex;
        }
    </style>
</head>
<body>

<script>
    const leng = "${comments}".length;
    let commentTime = new Array();
    <c:forEach var="comment" items="${comments}">
        // for (var i =0; i < leng ; i++){
        commentTime.put("modDate", "${comment.modDate}" );
        commentTime.put("regDate", "${comment.regDate}" );
            <%--modDate: "${comment.modDate}",--%>
            <%--regDate: "${comment.regDate}"--%>
        // };
    </c:forEach>

    const diffpos = document.getElementById("diffpos");
    function updateDifferences() {
        var now = new Date();
        for (var i = 0; i < leng; i++){
            var modDate = new Date(commentTime.modDate);
            var regDate = new Date(commentTime.regDate);
            var time = modDate ? modDate : regDate;
            var diffInMs = now - time;
            var diffInMinutes = Math.floor(diffInMs / (1000 * 60));

        }

        if (diffpos) {
            diffpos.textContent = diffInMinutes;
        }

    }

    updateDifferences();
    setInterval(updateDifferences, 60 * 1000); // Corrected to 60 * 1000 milliseconds
</script>
<%--<script>--%>
<%--    <c:forEach var="comment" items="${comments}">--%>
<%--        var mod_date = "${comment[i].mod_date}";//'2024-09-05T15:30:00Z';--%>
<%--        var reg_date =  "${comment[i].reg_date}";--%>

<%--        var time = mod_date ? new Date(mod_date) : new Date(reg_date);--%>

<%--        function updateDifference() {--%>
<%--            var now = new Date();--%>
<%--            var diffInMs = now - time;--%>
<%--            var diffInMinutes = Math.floor(diffInMs / (1000 * 60)); // 밀리초를 분으로 변환--%>

<%--            document.getElementById("diffpos").textContent = diffInMinutes;--%>
<%--            console.log(diffInMinutes);--%>
<%--        }--%>
<%--    </c:forEach>--%>

<%--        updateDifference();--%>
<%--        setInterval(updateDifference, 60 * 100);--%>

<%--</script>--%>
<div class="container">


    <h3>게시글 수정</h3>
    <form id="registerform" action="/updateboard/${detail.id}" method="post">
        <input class="w100" type="text" name="title" id="title" maxlength="100" placeholder="${detail.title}" value="<c:out value="${detail.title}"/>"/>
        <br/>
        <textarea class="w100" name="content" id="content" rows="30" cols="60" placeholder="${detail.content}"></textarea>
        <div class="bottbtnlist">
            <button onclick="toupdate('${detail.id}');" class="btn bglighblue">update!</button>
        </div>
    </form>
    <script>

        window.onload= function (){
            const cntdat = document.getElementById("inputdt");
            const printpos = document.getElementById("printpos");
            cntdat.addEventListener('input',function(){
                let num = cntdat.value.length;
                printpos.textContent= num;
            });
        }

        function sacje(id){
            if(confirm("정말로 삭제하시겠습니까?")){
                window.location.href ='/delboard/'+id;
            } else{ return false; }
        }
        function toupdate(id){
            if(confirm("해당 게시물을 업데이트 하시겠습니까?") == true ){
                alert("게시글이 수정되었습니다."); // 성공여부 체크 안하고 뜸
            }else{
                alert("게시글 업데이트에 실패하였습니다.");
            }
            window.location.href ='/detailviewbyid/'+id;// 여기서 업데이트 처리
        }

        function tolist_update(){
            if(confirm("작성중이던 데이터가 삭제될 수 있습니다. 목록으로 돌아가시겠습니까?") == true){
                window.location.href="/board";
            }else{
                return false;
            }
        }

    </script>
    <div id="bottbtnlist">
        <button onclick="sacje('${detail.id}');" class="btn bgred">삭제</button>
        <button onclick="tolist_update();" class="btn bggray">목록</button>
    </div>

    <hr style="margin:3% 0;">

    <c:choose>
    <c:when test="${not empty comments}">
    <c:forEach items="${comments}" var="comment">
    <p class="bold"><span>&nbsp;&nbsp;&nbsp;&nbsp;</span><c:out value="${comment.regMember}"/><span id="diffpos" class="fred ">&nbsp; 0 &nbsp;</span><span>분전</span></p>
    <div class="dt" style="height: 130px;">
        <br/>
        <p><c:out value="${comment.comment}"/></p>
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