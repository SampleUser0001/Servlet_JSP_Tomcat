<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="ittimfn.model.Book" %>
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
