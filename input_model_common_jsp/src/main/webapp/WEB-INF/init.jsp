<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
  import="ittimfn.sample.includejsp.enums.ApplicationCommonEnum"
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
  </script>
</head>

<body class="has-background-dark has-text-light">

  <%-- ナビバーのインクルード --%>
  <jsp:include page="./common/nav_bar.jsp" />
  <!-- メインセクション -->
  <section class="section">
    <div class="container">
      <div class="box">
        <h1 class="title has-text-primary">input_model_common_jsp</h1>
        <p class="subtitle">
          jsp importのサンプルです。
        </p>
        <form method="post" action="<%= request.getContextPath() %>/insert" >
          <jsp:include page="./common/form.jsp" />
          <button type="submit" class="button is-primary mt-3">送信</button>
        </form>
      </div>
    </div>
  </section>

  <%-- フッターのインクルード --%>
  <jsp:include page="./common/footer.jsp"/>
</body>
</html>
