# EL文を使う

- [EL文を使う](#el文を使う)

## ELが利用できる条件

- JSP 2.0（Servlet 2.4）以降で標準対応。
    - Tomcat 5.5 以降なら使用可。
- Servlet 2.3／JSP 1.2 以前や `web.xml` が 2.3 以下の場合は EL が無効
    - `isELIgnored="true"` や `jsp-config` の `el-ignored` を `true` に設定すると EL が評価されなくなる。

## バージョン確認方法

- `WEB-INF/web.xml` の `version` と `xsi:schemaLocation` を確認。
- コンテナは `catalina.sh version`（Windows は `catalina.bat version`）などで確認し、Servlet/JSP 仕様との対応表を参照。
- サーブレットから `getServletContext().getMajorVersion()` / `getMinorVersion()` を呼び出して記録する方法も有効。

## Servlet API バージョンをログに出すコード例

```java
package com.example.helloworld;

import javax.servlet.ServletContext;

public class VersionLogger {
    public void log(ServletContext context) {
        int major = context.getMajorVersion();
        int minor = context.getMinorVersion();
        context.log("Servlet API Version: " + major + "." + minor);
    }
}
```

## EL の動作を簡単に確認できる JSP

``` jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<body>
<p>${1 + 2}</p>
<p>${pageContext.request.contextPath}</p>
<p>${empty param.test}</p>
</body>
</html>
```

- 下記になるなら使用可能。
    - `${1 + 2}` -> `3`
    - `${pageContext.request.contextPath}` -> 実際のコンテキストパス
    - `${empty param.test}` -> `true`/`false`
- 使用不可環境では、そのままの文字列が表示される。

## フォーム値で EL を試す JSP の例

```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<body>
<form>
    <input type="text" name="test"/>
    <button type="submit">送信</button>
</form>
<p>${param.test}</p>
</body>
</html>
```

## JSP での値の参照方法
- EL 式（例: `${inputValue}`）は属性スコープを透過的に扱えるので推奨。
- スクリプトレット（例: `<% String greeting = (String) request.getAttribute("greeting"); %>`）も可能だが、可読性のため必要最小限に留め、可能なら EL/JSTL に統一する。
