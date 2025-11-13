<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>動的入力欄</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
    <style>
        table {
            width: 100%;
            margin-top: 20px;
        }
        th {
            background-color: #f5f5f5;
            padding: 10px;
            text-align: left;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .id-column {
            width: 100px;
            font-weight: bold;
        }
        .value-column {
            width: auto;
        }
        .action-column {
            width: 120px;
            text-align: center;
        }
    </style>
    <script>
        let itemCounter = 4; // 初期データが3件あるので4から開始

        function addInputField() {
            const tbody = document.getElementById('itemTableBody');
            const itemId = itemCounter++;
            const itemValue = 'Item ' + itemId;

            addTableRow(tbody, itemId, itemValue);
            console.log('Item added. Total rows:', tbody.children.length);
        }

        function addTableRow(tbody, itemId, itemValue) {
            const row = document.createElement('tr');

            // ID列
            const tdId = document.createElement('td');
            tdId.className = 'id-column';
            tdId.textContent = itemId;

            // Hidden input（IDのみ送信）
            const hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = 'itemIds';
            hiddenInput.value = itemId;
            tdId.appendChild(hiddenInput);

            // Value列
            const tdValue = document.createElement('td');
            tdValue.className = 'value-column';
            tdValue.textContent = itemValue;

            // 削除ボタン列
            const tdAction = document.createElement('td');
            tdAction.className = 'action-column';
            const deleteBtn = document.createElement('button');
            deleteBtn.type = 'button';
            deleteBtn.className = 'button is-danger is-small';
            deleteBtn.textContent = '削除';
            deleteBtn.onclick = function() { removeTableRow(this); };
            tdAction.appendChild(deleteBtn);

            row.appendChild(tdId);
            row.appendChild(tdValue);
            row.appendChild(tdAction);
            tbody.appendChild(row);
        }

        function removeTableRow(button) {
            const tbody = document.getElementById('itemTableBody');
            if (tbody.children.length > 1) {
                button.closest('tr').remove();
                console.log('Row removed. Remaining rows:', tbody.children.length);
            } else {
                alert('最低1つの行は必要です');
            }
        }

        // ポップアップを開く
        function openInputPopup() {
            const width = 500;
            const height = 300;
            const left = (screen.width - width) / 2;
            const top = (screen.height - height) / 2;
            const features = `width=${width},height=${height},left=${left},top=${top},resizable=yes,scrollbars=yes`;
            const contextPath = '<%= request.getContextPath() %>';
            const popupUrl = contextPath + '/inputPopup';
            console.log('Opening popup:', popupUrl);
            const popup = window.open(popupUrl, 'inputPopup', features);

            if (!popup || popup.closed || typeof popup.closed == 'undefined') {
                alert('ポップアップがブロックされました。ブラウザの設定を確認してください。');
                console.error('Popup was blocked');
            } else {
                console.log('Popup opened successfully');
            }
        }

        // ポップアップから呼ばれる関数（項目を追加）
        function addItemFromPopup(itemValue) {
            console.log('addItemFromPopup called with value:', itemValue);
            const tbody = document.getElementById('itemTableBody');
            const itemId = itemCounter++;

            addTableRow(tbody, itemId, itemValue);
            console.log('Item added successfully. Total rows:', tbody.children.length);
        }
    </script>
</head>
<body>
    <section class="section">
        <div class="container">
            <h1 class="title">動的テーブル行の追加・削除</h1>
            <p class="subtitle">テーブルの行を自由に追加・削除して、配列でサーバーに送信します。</p>

            <form method="post" action="dynamicInput">
                <table class="table is-striped is-fullwidth">
                    <thead>
                        <tr>
                            <th class="id-column">ID</th>
                            <th class="value-column">Value</th>
                            <th class="action-column">操作</th>
                        </tr>
                    </thead>
                    <tbody id="itemTableBody">
                        <!-- 初期データ -->
                        <tr>
                            <td class="id-column">
                                1
                                <input type="hidden" name="itemIds" value="1">
                            </td>
                            <td class="value-column">サンプルデータ1</td>
                            <td class="action-column">
                                <button type="button" class="button is-danger is-small" onclick="removeTableRow(this)">削除</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="id-column">
                                2
                                <input type="hidden" name="itemIds" value="2">
                            </td>
                            <td class="value-column">サンプルデータ2</td>
                            <td class="action-column">
                                <button type="button" class="button is-danger is-small" onclick="removeTableRow(this)">削除</button>
                            </td>
                        </tr>
                        <tr>
                            <td class="id-column">
                                3
                                <input type="hidden" name="itemIds" value="3">
                            </td>
                            <td class="value-column">サンプルデータ3</td>
                            <td class="action-column">
                                <button type="button" class="button is-danger is-small" onclick="removeTableRow(this)">削除</button>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="field is-grouped">
                    <div class="control">
                        <button type="button" class="button is-success" onclick="addInputField()">+ 行を追加</button>
                    </div>
                    <div class="control">
                        <button type="button" class="button is-info" onclick="openInputPopup()">+ ポップアップで追加</button>
                    </div>
                    <div class="control">
                        <button type="submit" class="button is-primary">送信</button>
                    </div>
                </div>
            </form>

            <%
                String[] receivedItemIds = (String[]) request.getAttribute("receivedItemIds");
                if (receivedItemIds != null && receivedItemIds.length > 0) {
            %>
            <div class="box mt-5">
                <h2 class="title is-4">受信したデータ</h2>
                <div class="content">
                    <table class="table is-striped is-fullwidth">
                        <thead>
                            <tr>
                                <th>ID</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            for (int i = 0; i < receivedItemIds.length; i++) {
                                if (receivedItemIds[i] != null && !receivedItemIds[i].trim().isEmpty()) {
                        %>
                            <tr>
                                <td><strong><%= receivedItemIds[i] %></strong></td>
                            </tr>
                        <%
                                }
                            }
                        %>
                        </tbody>
                    </table>
                    <div class="notification is-success is-light">
                        <strong>合計:</strong> <%= receivedItemIds.length %> 件のIDを受信しました
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </section>
</body>
</html>
