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

function submit_form(path, keys, contextPath) {
    const form = document.createElement("form");
    form.method = "POST";
    form.action = (contextPath || "") + "/" + path;

    keys.map(
        key => form.appendChild(genChild(key))
    );
    document.body.appendChild(form);
    form.submit();
}
