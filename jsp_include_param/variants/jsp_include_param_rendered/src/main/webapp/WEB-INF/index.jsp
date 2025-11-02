<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
  import="ittimfn.sample.includejsp.enums.ApplicationCommonEnum"
  import="ittimfn.sample.includejsp.enums.OptionsEnum01"  
%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title><%= ApplicationCommonEnum.APPLICATION_TITLE.getDefaultValue() %></title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css">
  <script defer src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6/js/all.min.js"></script>

  <script>
    const submit = () => {
      document.forms[0].submit();
      
    }
  </script>
</head>

<body class="has-background-dark has-text-light">

  <%-- ナビバーのインクルード --%>
  <jsp:include page="./common/nav_bar.jsp" />
  <!-- メインセクション -->
  <section class="section">
    <div class="container">
      <div class="box">
        <h1 class="title has-text-primary">jsp_include_param_rendered</h1>
        <p class="subtitle">
          jsp importのサンプルです。
        </p>
        <!-- nameにApplicationCommonEnum.PULLDOWN_KEY.getCode() は使えないぞ！ -->
        <!-- valueにOptionsEnum01.SELECT_ID は使えないぞ！ -->
        <!-- コメントをjsp:includeの中に書くとエラーになるぞ！ -->
        <form method="post" action="<%= request.getContextPath() %>/" >
          <p>
          <jsp:include page="./common/pulldown.jsp" >
            <jsp:param name="pulldown.key" value="sample01" />
            <jsp:param name="onchange" value="submit" />
          </jsp:include>
          </p>

          <p>
          <jsp:include page="./common/pulldown.jsp" >
            <jsp:param name="pulldown.key" value="sample02" />
            <jsp:param name="onchange" value="submit" />
          </jsp:include>
          </p>

        </form>
      </div>
    </div>
  </section>

  <%-- フッターのインクルード --%>
  <jsp:include page="./common/footer.jsp"/>
</body>
</html>
