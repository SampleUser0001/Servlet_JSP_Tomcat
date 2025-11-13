<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>項目入力</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
    <script>
        function registerItem() {
            console.log('registerItem called');
            const itemValue = document.getElementById('itemInput').value;
            console.log('Item value:', itemValue);

            if (!itemValue || itemValue.trim() === '') {
                alert('項目を入力してください');
                return;
            }

            // 親ウィンドウが存在するか確認
            console.log('Checking window.opener:', window.opener);
            if (!window.opener) {
                alert('エラー: 親ウィンドウが見つかりません。\n親画面から開いてください。');
                console.error('window.opener is null');
                return;
            }

            // 親ウィンドウが閉じられていないか確認
            if (window.opener.closed) {
                alert('エラー: 親ウィンドウが閉じられています。');
                console.error('window.opener is closed');
                return;
            }

            // 親ウィンドウに関数が存在するか確認
            console.log('Checking addItemFromPopup function:', typeof window.opener.addItemFromPopup);
            if (typeof window.opener.addItemFromPopup !== 'function') {
                alert('エラー: 親ウィンドウの関数が見つかりません。\naddItemFromPopup関数が定義されているか確認してください。');
                console.error('window.opener.addItemFromPopup is not a function');
                console.log('Available functions:', Object.keys(window.opener).filter(k => typeof window.opener[k] === 'function'));
                return;
            }

            try {
                // 親ウィンドウの関数を呼び出して項目を追加
                console.log('Calling window.opener.addItemFromPopup with:', itemValue);
                window.opener.addItemFromPopup(itemValue);
                console.log('Successfully called addItemFromPopup, closing window');
                window.close();
            } catch (error) {
                alert('エラーが発生しました: ' + error.message);
                console.error('Error calling addItemFromPopup:', error);
            }
        }

        function cancel() {
            window.close();
        }

        // Enterキーで登録
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('itemInput').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    registerItem();
                }
            });
        });
    </script>
</head>
<body>
    <section class="section">
        <div class="container" style="max-width: 500px;">
            <h1 class="title is-4">Value を入力</h1>

            <div class="field">
                <label class="label">Value</label>
                <div class="control">
                    <input class="input" type="text" id="itemInput" placeholder="Value を入力してください" autofocus>
                </div>
                <p class="help">IDは自動的に採番されます</p>
            </div>

            <div class="field is-grouped">
                <div class="control">
                    <button type="button" class="button is-primary" onclick="registerItem()">登録</button>
                </div>
                <div class="control">
                    <button type="button" class="button is-light" onclick="cancel()">キャンセル</button>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
