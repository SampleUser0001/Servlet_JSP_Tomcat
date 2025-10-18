<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
