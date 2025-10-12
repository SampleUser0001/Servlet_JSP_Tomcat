<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ittimfn.model.Book" %>
<%
    // 親ページから渡されたBookオブジェクトを取得（編集時）
    Book book = (Book) request.getAttribute("book");
    String mode = (String) request.getAttribute("mode"); // "new" or "edit"

    // 初期値の設定
    String bookId = (book != null) ? book.getId() : "";
    String title = (book != null) ? book.getTitle() : "";
    String author = (book != null) ? book.getAuthor() : "";
    String genre = (book != null) ? book.getGenre() : "";
    String year = (book != null) ? String.valueOf(book.getYear()) : "";
%>

<!-- 共通入力フィールド -->
<% if ("edit".equals(mode)) { %>
<div class="form-group">
    <label for="bookId">書籍ID: <span class="required">*</span></label>
    <input type="text" id="bookId" name="bookId" value="<%= bookId %>"
           readonly class="form-control">
    <small class="form-text">※編集時は変更できません</small>
</div>
<% } %>

<div class="form-group">
    <label for="title">タイトル: <span class="required">*</span></label>
    <input type="text" id="title" name="title" value="<%= title %>"
           required maxlength="100" class="form-control"
           placeholder="書籍のタイトルを入力してください">
</div>

<div class="form-group">
    <label for="author">著者: <span class="required">*</span></label>
    <input type="text" id="author" name="author" value="<%= author %>"
           required maxlength="50" class="form-control"
           placeholder="著者名を入力してください">
</div>

<div class="form-group">
    <label for="genre">ジャンル: <span class="required">*</span></label>
    <select id="genre" name="genre" required class="form-control">
        <option value="">選択してください</option>
        <option value="技術書" <%= "技術書".equals(genre) ? "selected" : "" %>>技術書</option>
        <option value="小説" <%= "小説".equals(genre) ? "selected" : "" %>>小説</option>
        <option value="ビジネス書" <%= "ビジネス書".equals(genre) ? "selected" : "" %>>ビジネス書</option>
        <option value="参考書" <%= "参考書".equals(genre) ? "selected" : "" %>>参考書</option>
    </select>
</div>

<div class="form-group">
    <label for="year">出版年: <span class="required">*</span></label>
    <input type="number" id="year" name="year" value="<%= year %>"
           required min="1900" max="2100" class="form-control"
           placeholder="出版年を入力してください（例: 2023）">
</div>
