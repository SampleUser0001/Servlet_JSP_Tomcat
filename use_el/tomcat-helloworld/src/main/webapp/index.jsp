<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Hello JSP</title>
</head>
<body>
<h1>Hello JSP!</h1>
<p>JSPからの挨拶です。<a href="${pageContext.request.contextPath}/hello">サーブレット版はこちら</a></p>
<p>サーブレット版はサーブレットから値を取得して、WEB-INF/view/hello.jspにフォワードします。</p>
<p><a href="${pageContext.request.contextPath}/hello">入力フォームはこちら</a></p>
</body>
</html>
