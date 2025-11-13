<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="ittimfn.model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>書籍検索</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            padding: 30px;
        }

        h1 {
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
            text-align: center;
        }

        .search-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: 500;
        }

        input[type="text"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .btn-group {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        button {
            flex: 1;
            padding: 12px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-search {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-reset {
            background: #6c757d;
            color: white;
        }

        .btn-reset:hover {
            background: #5a6268;
        }

        .results {
            margin-top: 30px;
        }

        .result-count {
            background: #e7f3ff;
            padding: 10px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            color: #0066cc;
            font-weight: 500;
        }

        .no-results {
            text-align: center;
            padding: 40px;
            color: #999;
            font-size: 16px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: 500;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #f8f9fa;
        }

        .highlight {
            background-color: #ffff00;
            font-weight: bold;
            padding: 2px 4px;
            border-radius: 2px;
        }

        a {
            color: #667eea;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>書籍検索</h1>

        <!-- 検索フォーム -->
        <div class="search-form">
            <form method="get" action="${pageContext.request.contextPath}/bookSearchPopup">
                <div class="form-group">
                    <label for="keyword">キーワード</label>
                    <input type="text" id="keyword" name="keyword"
                           value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>"
                           placeholder="タイトルまたは著者名で検索">
                </div>

                <div class="form-group">
                    <label for="genre">ジャンル</label>
                    <select id="genre" name="genre">
                        <option value="">全て</option>
                        <%
                            String selectedGenre = (String) request.getAttribute("genre");
                            String[] genres = {"プログラミング", "データベース", "AI・機械学習", "Web開発", "セキュリティ"};
                            for (String genre : genres) {
                                String selected = genre.equals(selectedGenre) ? "selected" : "";
                        %>
                        <option value="<%= genre %>" <%= selected %>><%= genre %></option>
                        <%
                            }
                        %>
                    </select>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn-search">検索</button>
                    <button type="button" class="btn-reset" onclick="resetForm()">クリア</button>
                </div>
            </form>
        </div>

        <!-- 検索結果 -->
        <div class="results">
            <%
                @SuppressWarnings("unchecked")
                List<Book> books = (List<Book>) request.getAttribute("books");
                String keyword = (String) request.getAttribute("keyword");

                if (books != null && !books.isEmpty()) {
            %>
                <div class="result-count">
                    <%= books.size() %>件の書籍が見つかりました
                </div>
                <div style="margin: 20px 0; padding: 15px; background: #e7f3ff; border-radius: 5px;">
                    <p style="margin: 0 0 10px 0; font-weight: bold; color: #0066cc;">
                        検索結果を親画面に反映します
                    </p>
                    <button onclick="applySearchResults()" class="btn-search" style="width: auto; padding: 10px 30px;">
                        親画面をハイライト表示
                    </button>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>書籍ID</th>
                            <th>タイトル</th>
                            <th>著者</th>
                            <th>ジャンル</th>
                            <th>出版年</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Book book : books) { %>
                        <tr>
                            <td><%= book.getId() %></td>
                            <td><%= highlightText(book.getTitle(), keyword) %></td>
                            <td><%= highlightText(book.getAuthor(), keyword) %></td>
                            <td><%= book.getGenre() %></td>
                            <td><%= book.getYear() %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <%
                } else if (keyword != null && !keyword.isEmpty()) {
            %>
                <div class="no-results">
                    検索条件に一致する書籍が見つかりませんでした
                </div>
            <%
                }
            %>
        </div>
    </div>

    <%!
        // テキストをハイライト表示するメソッド
        private String highlightText(String text, String keyword) {
            if (keyword == null || keyword.isEmpty() || text == null) {
                return escapeHtml(text);
            }

            String escapedText = escapeHtml(text);
            String escapedKeyword = escapeHtml(keyword);

            // 大文字小文字を区別せずにハイライト
            String pattern = "(?i)(" + escapedKeyword.replace("(", "\\(").replace(")", "\\)") + ")";
            return escapedText.replaceAll(pattern, "<span class=\"highlight\">$1</span>");
        }

        // HTMLエスケープ
        private String escapeHtml(String text) {
            if (text == null) return "";
            return text.replace("&", "&amp;")
                       .replace("<", "&lt;")
                       .replace(">", "&gt;")
                       .replace("\"", "&quot;")
                       .replace("'", "&#x27;");
        }
    %>

    <script>
        function resetForm() {
            document.getElementById('keyword').value = '';
            document.getElementById('genre').value = '';
        }

        function applySearchResults() {
            <%
                if (books != null && !books.isEmpty()) {
                    // 検索結果のIDリストをJavaScript配列として出力
                    StringBuilder bookIds = new StringBuilder("[");
                    for (int i = 0; i < books.size(); i++) {
                        if (i > 0) bookIds.append(",");
                        bookIds.append(books.get(i).getId());
                    }
                    bookIds.append("]");
            %>
            const matchedBookIds = <%= bookIds.toString() %>;
            const keyword = "<%= keyword != null ? keyword.replace("\"", "\\\"") : "" %>";

            // 親画面に検索結果を送信
            if (window.opener && !window.opener.closed) {
                window.opener.highlightSearchResults(matchedBookIds, keyword);
                alert('親画面をハイライト表示しました');
            } else {
                alert('親画面が見つかりません');
            }
            <%
                }
            %>
        }
    </script>
</body>
</html>
