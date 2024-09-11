<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>(ʃƪ ˘ ³˘) Board List </title>
    <style>
        html,body{
            margin:0;
            padding: 0;
            /*background-color: #333333;*/
            /*color:white;*/
        }
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
        .ellip {
            white-space: nowrap;
            text-overflow:ellipsis !important;
            /*max-width: 50px;*/
        }
        #content{
            height:300px;
        }

        div.container table.w100 td {
            width:35px;
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
        .bggreen{
            background-color: #4FD86D;
        }
        .bglighblue{
            background-color: #14AAFF;
        }
        .bggray{
            background-color: #CCCCCC;
        }
        #files{
            display: inline-block;
        }

        #bottbtnlist{
            width:100%;
            padding-top:15px;
            padding-left:39%;

        }
        .inb{
            display: inline-block;
        }
        .right0 {
            width:66%;
            position:absolute;
            right:0%;

        }
        .bold {
            font-weight: 800;
        }
        table#list, td{
            border-collapse: collapse;
            border: 1px solid antiquewhite;
        }

        #paginglist{
            width:100%;
        }


        #paginglist ul {
            width: 80%;
            margin:15px auto;
            list-style: none;
            display: inline-block;
            left: 0;
        }
        #paginglist ul li.page-item{
            border:1px solid #CCCCCC;
            width: 30px;
            height: 30px;
            display: inline-block;
            text-align: center;
            font-size:1.1em;
            font-weight: 600;
            margin-left: 3px;
            justify-content: space-around;
        }

        #paginglist ul li.page-item a{
            text-decoration:none;
            color:#333;
        }
        #paginglist ul li.page-item a:hover{
            background-color:#14AAFF;
            font-weight: bold;
            color:navajowhite;
        }

        #paginglist button {
            width:14%;
            display: inline-block;
            right:0;
        }
        td#todetail:hover{
            font-weight: bold;
            cursor: grab;
        }


    /*   페이징 */
        .pagination {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .page-item {
            margin: 0 2px;
        }

        .page-link {
            display: block;
            padding: 0.5rem 0.75rem;
            font-size: 1rem;
            line-height: 1.25;
            text-align: center;
            text-decoration: none;
            color: #007bff;
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
        }

        .page-item.active .page-link {
            z-index: 1;
            color: #fff;
            background-color: #007bff;
            border-color: #007bff;
        }

        .page-link:hover {
            color: #0056b3;
            background-color: #e9ecef;
            border-color: #dee2e6;
        }



    </style>
    <script>
        function toupdate(id) {
            window.location.href = "/detailviewbyid/" + id;
        }

        const searchForm = document.getElementById("searchForm");
        const searching = document.getElementById("searching").value;
        const sccon = document.getElementById("sccon").value;
        const staystatus = localStorage.getItem('staystatus');
        if(staystatus) {
            sccon.value= staystatus;
        }

        function consearch() {
            console.log("searching value:::", searching);
            localStorage.setItem('searching', searching);
            localStorage.setItem('sccon', sccon);
            searchForm.addEventListener('submit', function () {
                ssearching = localStorage.getItem(searching);
                localStorage.getItem(sccon);
            });
            const searching = document.getElementById("searching").value;
            const sccon = document.getElementById("sccon").value;
            $.ajax({
                url: "/consearch",
                method: "GET",
                data: {
                    "searching": searching,
                    "sccon": sccon
                }
            });
        }
    </script>
</head>
<body>
<script>
    window.onload = function () {
        if ("${datamsg}") {
            alert("${datamsg}");
        }
        if ("${msg}") {
            alert("${msg}");
        }

        let totalcnt = "0";
        let currcnt = 0;
        if ("${totalCount}") {
            totalcnt = "${totalCount}";
        }
        document.getElementById("totalcnt").textContent = totalcnt;

        if ("${currcnt}") {
            currcnt = "${currcnt}";
        }
        document.getElementById("currcnt").textContent = currcnt;

        const pitems = document.getElementsByClassName('page-item');
        for (var i = 0; i < pitems.length; i++) {
            pitems[i].addEventListener('click', function () {
                this.ClassList.add('active');
            })

        }

        const searchForm = document.getElementById("searchForm");
        const sccon = document.getElementById("sccon");
        const staystatus = localStorage.getItem('staystatus');
        if (staystatus) {
            sccon.value = staystatus;
        }

        searchForm.addEventListener('submit', function () {
            localStorage.setItem('staystatus', sccon.value);
        });
    }
</script>
<div class="container">
    <h3>게시판 목록</h3>
    <p class="inb">검색된 게시물 <span id="currcnt" style="color:#14AAFF"> 0 </span> / 총 게시물 <span id="totalcnt" style="color:#14AAFF"> 0 </span></p>
    <div class="inb right0" >
        <form action="/consearch" method="get" id="searchForm" class="inb right0" >
            <label for="searching">검색조건</label>
            <select name="조회사항" id="searching">
                <option value="작성자">작성자</option>
                <option value="제목">제목</option>
                <option value="작성일">작성일</option>
            </select>
            <input type="text" name="sccon" id="sccon">
            <input type="submit" value="검색" class="bglighblue btn" style="width:50px;" />
        </form>
    </div>


    <table id="list" class="w100" style="border: 1px solid black; text-align: center;">
        <tr class="bggray bold">
            <td style="width:10%;">번호</td>
            <td style="width:50%;">제목</td>
            <td style="width:15%;">작성자</td>
            <td style="width:25%;">작성일</td>
        </tr>
        <c:choose>
            <c:when test="${not empty list}">
                <c:forEach var="li" items="${list}">
                    <tr>
                        <td><c:out value="${li.id}"/></td>
                        <td style="text-align: left; padding-left: 20px;" id="todetail" class="ellip" onclick="toupdate(parseInt('${li.id}'));"><c:out value="${li.title}"/></td>
                        <td><c:out value="${li.regMember}"/></td>
                        <td><c:out value="${li.display_date}"/></td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td style="text-align: center;" colspan="4">조회되는 게시글이 없습니다.</td>
                </tr>
            </c:otherwise>
        </c:choose>

    </table>
    <div id="bottbtnlist"class="w100" style="width:65%;">
        <div class="optirow" style="width:20%;left:0;">
            <button onclick="window.location.href='/insert'" class="bglighblue btn" style="display:inline-block;width:70px;position:absolute; transform:translate(450px,12px)">등록</button>
        </div>

        <nav id="paginglist" aria-label="Page navigation example" style="width:80%;margin-left:-120px;text-align: center;">
            <ul class="pagination" style="list-style: none; display: inline-flex;">
                <!-- Previous Button -->
                <c:if test="${nowPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="<c:url value='/consearch'/>?page=${nowPage - 1}&size=${size}" aria-label="Previous">
                            &laquo;
                        </a>
                    </li>
                </c:if>
                <c:if test="${nowPage <= 1}">
                    <li class="page-item disabled">
                        <span class="page-link" aria-label="Previous">&laquo;</span>
                    </li>
                </c:if>

                <!-- Page Number Links -->
                <c:forEach var="i" begin="1" end="${totalCount}">
                    <li class="page-item <c:if test="${i == nowPage}">active</c:if>">
                        <a class="page-link" href="<c:url value='/consearch'/>?page=${i}&size=20">
                                ${i}
                        </a>
                    </li>
                </c:forEach>

                <!-- Next Button -->
                <c:if test="${nowPage < endPage}">
                    <li class="page-item">
                        <a class="page-link" href="<c:url value='/consearch'/>?page=${nowPage + 1}&size=${size}" aria-label="Next">
                            &raquo;
                        </a>
                    </li>
                </c:if>
                <c:if test="${nowPage >= endPage}">
                    <li class="page-item disabled">
                        <span class="page-link" aria-label="Next">&raquo;</span>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>



</body>
</html>