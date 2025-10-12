<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ittimfn.model.Book" %>
<%
    Book book = (Book) request.getAttribute("book");
    if (book != null) {
%>
<div class="detail-container">
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
</div>
<%
    }
%>
