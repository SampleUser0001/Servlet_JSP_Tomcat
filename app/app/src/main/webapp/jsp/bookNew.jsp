<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>書籍新規登録</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 {
            color: #333;
            border-bottom: 3px solid #4CAF50;
            padding-bottom: 10px;
        }
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .form-control:focus {
            outline: none;
            border-color: #4CAF50;
        }
        .required {
            color: red;
        }
        .form-text {
            color: #666;
            font-size: 12px;
            margin-top: 5px;
        }
        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #999;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #888;
        }
    </style>
</head>
<body>
    <h1>書籍新規登録</h1>

    <div class="form-container">
        <form method="post" action="${pageContext.request.contextPath}/bookCreate">
            <%
                // 新規登録モードを設定
                request.setAttribute("mode", "new");
            %>
            <!-- 共通フィールドをインクルード -->
            <jsp:include page="bookFormFields.jsp" />

            <div class="button-group">
                <button type="submit" class="btn btn-primary">登録</button>
                <a href="${pageContext.request.contextPath}/bookSearch" class="btn btn-secondary">キャンセル</a>
            </div>
        </form>
    </div>
</body>
</html>
