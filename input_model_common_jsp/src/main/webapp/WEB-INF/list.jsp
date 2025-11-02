<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
  import="ittimfn.sample.includejsp.enums.ApplicationCommonEnum"
  import="java.util.List"
  import="ittimfn.sample.includejsp.model.InputModel"
  import="ittimfn.sample.includejsp.enums.FormEnum"
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
        <table class="table is-fullwidth is-striped">
          <thead>
            <% for (FormEnum formEnum : FormEnum.values()) { %>
              <th><%= formEnum.getLabel() %></th>
            <% } %>
          </thead>

          <%
            List<InputModel> list = (List<InputModel>) request.getAttribute("list");
          %>

          <tbody>
            <% for (InputModel model : list) { %>
              <tr style="cursor: pointer;" onclick="location.href='<%= request.getContextPath() %>/update?formid=<%= model.getFormid() %>'">
                <td><%= model.getFormid() %></td>
                <td><%= model.getValue() %></td>
              </tr>
            <% } %>
          </tbody>
        </table>
        <a class="button is-link" href="<%= request.getContextPath() %>/input">新規作成</a>
      </div>
    </div>
  </section>

  <%-- フッターのインクルード --%>
  <jsp:include page="./common/footer.jsp"/>
</body>
</html>
