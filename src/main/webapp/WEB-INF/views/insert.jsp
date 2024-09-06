<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>insert</title>
    <style>
        html,body{
            margin:0;
            padding: 0;
            background-color: #333333;
            color:white;
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
        #content{
            height:300px;
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

        .bottbtnlist{
            width:100%;
            padding-top:15px;
            padding-left:39%;

        }
    </style>
</head>
<body>
    <div class="container">
        <h3>게시판 등록</h3>
        <form id="registerform" action="/register" method="post">
            <input class="w100" type="text" name="title" id="title" maxlength="100" placeholder=" inset title here (*´ ˘ `*).｡oO ( ♡ )"/>
            <br/>
            <textarea class="w100" name="content" id="content" rows="30" cols="60" placeholder="insert content here (ᇂ_Jᇂ)"></textarea>
            <div class="bottbtnlist">
                <button onclick="upload();" id ="submit" class="btn bglighblue" >등록</button>
            </div>
        </form>
        <div class="bottbtnlist">
            <button class="btn bggray" onclick="backchk()">취소</button>
        </div>
    </div>
    <script>
        function uptodbchk() {
            if (confirm("글 등록을 요청합니다.")) {
                window.location.href = "/register";
            }
        }

        function backchk() {
            if (confirm("작성중인 글이 있습니다. 이전 페이지로 이동하시겠습니까?")) {
                window.history.back()
            }
        }

                // url: "redirect:/",
        function ajax(){

            $.ajax({
                url: "redirect:/",
                type: "POST" ,
                success: function(){
                    alert("게시글이 등록되었습니다.");
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    // 실패 시 알림 처리
                    alert("오류가 발생했습니다: " + textStatus);
                }
            });
        }
    </script>


</body>
</html>
