<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>

<%
    // JSP 스크립틀릿을 사용하여 데이터 변수 선언
    String name = "John Doe";
    int age = 30;
    String email = "john.doe@example.com";
%>

<!-- 데이터 출력 -->
<p>Name: <%= name %></p>
<p>Age: <%= age %></p>
<p>Email: <%= email %></p>
</body>
</html>