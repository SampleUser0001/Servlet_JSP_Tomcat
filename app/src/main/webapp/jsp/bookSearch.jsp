<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="ittimfn.model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>書籍検索</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 {
            color: #333;
            border-bottom: 3px solid #4CAF50;
            padding-bottom: 10px;
        }
        .search-form {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .search-form label {
            display: inline-block;
            width: 120px;
            font-weight: bold;
        }
        .search-form input[type="text"],
        .search-form select {
            padding: 8px;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 4px;
            margin-bottom: 10px;
        }
        .search-form button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 30px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-left: 120px;
        }
        .search-form button:hover {
            background-color: #45a049;
        }
        .results {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .result-count {
            color: #666;
            margin-bottom: 15px;
            font-size: 14px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
        .no-results {
            text-align: center;
            color: #999;
            padding: 30px;
        }
        .detail-container {
            background-color: #fafafa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            border: 1px solid #e0e0e0;
        }
        .book-header {
            text-align: center;
            padding: 15px;
            background-color: #f0f0f0;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        .book-title {
            font-size: 22px;
            color: #333;
            margin: 8px 0;
            font-weight: bold;
        }
        .book-id {
            color: #999;
            font-size: 13px;
        }
        .detail-row {
            margin-bottom: 15px;
            padding: 12px;
            background-color: white;
            border-radius: 4px;
            border-left: 3px solid #4CAF50;
        }
        .detail-label {
            font-weight: bold;
            color: #4CAF50;
            display: inline-block;
            width: 120px;
            font-size: 14px;
        }
        .detail-value {
            font-size: 16px;
            color: #333;
        }
        .btn-new {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
        }
        .btn-new:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>書籍検索システム</h1>

    <!-- 検索フォーム -->
    <div class="search-form">
        <form method="get" action="${pageContext.request.contextPath}/bookSearch">
            <div>
                <label for="keyword">キーワード:</label>
                <input type="text" id="keyword" name="keyword" value="${keyword}"
                       placeholder="タイトルまたは著者名で検索">
            </div>
            <div>
                <label for="genre">ジャンル:</label>
                <select id="genre" name="genre">
                    <option value="">すべて</option>
                    <option value="技術書" ${genre == '技術書' ? 'selected' : ''}>技術書</option>
                </select>
            </div>
            <button type="submit">検索</button>
        </form>
    </div>

    <!-- 検索結果 -->
    <div class="results">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
            <h2 style="margin: 0;">検索結果</h2>
            <a href="${pageContext.request.contextPath}/bookNew" class="btn-new">
                + 新規登録
            </a>
        </div>
        <%
            @SuppressWarnings("unchecked")
            List<Book> books = (List<Book>) request.getAttribute("books");
            if (books != null && !books.isEmpty()) {
        %>
            <div class="result-count">
                <%= books.size() %>件の書籍が見つかりました
            </div>
            <table>
                <thead>
                    <tr>
                        <th>書籍ID</th>
                        <th>タイトル</th>
                        <th>著者</th>
                        <th>ジャンル</th>
                        <th>出版年</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Book book : books) { %>
                    <tr>
                        <td><%= book.getId() %></td>
                        <td><%= book.getTitle() %></td>
                        <td><%= book.getAuthor() %></td>
                        <td><%= book.getGenre() %></td>
                        <td><%= book.getYear() %></td>
                        <td>
                            <a href="${pageContext.request.contextPath}/bookDetail?id=<%= book.getId() %>">
                                詳細
                            </a>
                            |
                            <a href="${pageContext.request.contextPath}/bookEdit?id=<%= book.getId() %>">
                                編集
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <!-- 検索結果の詳細情報 -->
            <div style="margin-top: 40px;">
                <h2>検索結果詳細</h2>
                <%
                    for (Book book : books) {
                        request.setAttribute("book", book);
                %>
                    <jsp:include page="bookDetailFragment.jsp" />
                <%
                    }
                %>
            </div>
        <%
            } else {
        %>
            <div class="no-results">
                検索条件に一致する書籍が見つかりませんでした
            </div>
        <%
            }
        %>
    </div>
</body>
</html>
