<%@ page language="java" contentType="text/html; charset=EUC-KR"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<h2>User List</h2>
<table border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
    </tr>
    </thead>
    <tbody>
    <!-- 데이터가 존재하는 경우 반복하여 출력 -->
    <c:forEach var="user" items="${list}">
        <tr>
            <td><c:out value="${user.id}"/></td>
            <td><c:out value="${user.title}"/></td>
            <td><c:out value="${user.regMember}"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>