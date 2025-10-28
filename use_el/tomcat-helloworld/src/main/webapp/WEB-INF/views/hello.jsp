<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Hello JSP</title>
</head>
<body>
<h1>Hello JSP!</h1>
<p>${greeting}</p>
<p><a href="${pageContext.request.contextPath}/">トップへ戻る</a></p>
</body>
</html>
