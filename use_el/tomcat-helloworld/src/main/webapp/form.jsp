<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>入力フォーム</title>
</head>
<body>
<h1>入力フォーム</h1>
<form action="${pageContext.request.contextPath}/hello" method="get">
    <label for="name">お名前:</label>
    <input type="text" id="name" name="name" value="${inputValue}"/>
    <button type="submit">送信</button>
</form>
<%
    String greeting = (String) request.getAttribute("greeting");
    if (greeting != null) {
%>
<p><%= greeting %></p>
<%
    }
%>
<p><a href="${pageContext.request.contextPath}/">トップへ戻る</a></p>
</body>
</html>
