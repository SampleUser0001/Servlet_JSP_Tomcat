<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ittimfn.model.Book" %>
<%
    // インクルードされているかどうかを判定
    Boolean isIncluded = (request.getAttribute("javax.servlet.include.request_uri") != null);
    Book book = (Book) request.getAttribute("book");
%>
<% if (!isIncluded) { %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>書籍詳細</title>
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
        .detail-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .detail-row {
            margin-bottom: 20px;
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        .detail-row:last-child {
            border-bottom: none;
        }
        .detail-label {
            font-weight: bold;
            color: #4CAF50;
            display: inline-block;
            width: 150px;
            font-size: 14px;
        }
        .detail-value {
            font-size: 18px;
            color: #333;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .back-link:hover {
            background-color: #45a049;
        }
        .book-header {
            text-align: center;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .book-title {
            font-size: 28px;
            color: #333;
            margin: 10px 0;
        }
        .book-id {
            color: #999;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <h1>書籍詳細情報</h1>
<% } %>

    <% if (book != null) { %>
        <div class="detail-container" style="<%= isIncluded ? "margin-bottom: 20px;" : "" %>">
            <div class="book-header">
                <div class="book-id">書籍ID: <%= book.getId() %></div>
                <div class="book-title"><%= book.getTitle() %></div>
            </div>

            <div class="detail-row">
                <span class="detail-label">タイトル:</span>
                <span class="detail-value"><%= book.getTitle() %></span>
            </div>

            <div class="detail-row">
                <span class="detail-label">著者:</span>
                <span class="detail-value"><%= book.getAuthor() %></span>
            </div>

            <div class="detail-row">
                <span class="detail-label">ジャンル:</span>
                <span class="detail-value"><%= book.getGenre() %></span>
            </div>

            <div class="detail-row">
                <span class="detail-label">出版年:</span>
                <span class="detail-value"><%= book.getYear() %>年</span>
            </div>

            <% if (!isIncluded) { %>
            <a href="${pageContext.request.contextPath}/bookSearch" class="back-link">
                ← 検索画面に戻る
            </a>
            <% } %>
        </div>
    <% } else { %>
        <div class="detail-container">
            <p>書籍情報が見つかりません。</p>
            <% if (!isIncluded) { %>
            <a href="${pageContext.request.contextPath}/bookSearch" class="back-link">
                ← 検索画面に戻る
            </a>
            <% } %>
        </div>
    <% } %>

<% if (!isIncluded) { %>
</body>
</html>
<% } %>
