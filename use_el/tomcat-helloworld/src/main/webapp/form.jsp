<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>入力フォーム</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<h1>入力フォーム</h1>
<form action="${pageContext.request.contextPath}/hello" method="post">
    <label for="name">お名前:</label>
    <input type="text" id="name" name="name" value="${inputValue}"/>
    <button type="submit">送信</button>
</form>
<p><button type="button" onclick="send_message()">非同期送信</button></p>
<p><button type="button" onclick="submit_form()">submit_form</button></p>
<p><button type="button" onclick="submit_form_jQuery()">submit_form_jQuery</button></p>

<script>
    function send_message() {
        const nameField = document.getElementById("name");
        const params = new URLSearchParams();
        params.append("name", nameField ? nameField.value : "");

        fetch("${pageContext.request.contextPath}/hello", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
            },
            body: params.toString(),
        })
            .then((response) => {
                if (!response.ok) {
                    throw new Error(response.status + " " + response.statusText);
                }
                return response.text();
            })
            .then((html) => {
                document.open();
                document.write(html);
                document.close();
            })
            .catch((error) => {
                console.error("send_message failed", error);
                alert("通信に失敗しました。");
            });
    }

    function genChild(elementId, value) {
        const existingElement = document.getElementById(elementId);

        // valueが指定されていない場合、既存要素の値を使用
        if (value === undefined || value === null) {
            value = existingElement ? existingElement.value || "" : "";
        }

        // hidden inputを作成
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = elementId;
        input.value = value;

        return input;
    }

    function submit_form() {
        const form = document.createElement("form");
        form.method = "POST";
        form.action = "${pageContext.request.contextPath}/hello";

        form.appendChild(genChild("name"));
        form.appendChild(genChild("send", "value"));

        document.body.appendChild(form);
        form.submit();
    }
    function submit_form_jQuery() {
        const nameValue = $("#name").val() || "";
        const $form = $("<form>", {
            method: "POST",
            action: "${pageContext.request.contextPath}/hello",
        });

        $("<input>", {
            type: "hidden",
            name: "name",
            value: nameValue,
        }).appendTo($form);

        $form.appendTo("body");
        $form.trigger("submit");
    }
</script>
<%
    String greeting = (String) request.getAttribute("greeting");
    if (greeting != null) {
%>
<p><%= greeting %></p>
<%
    }
%>
<p><a href="${pageContext.request.contextPath}/">トップへ戻る</a></p>
</body>
</html>
