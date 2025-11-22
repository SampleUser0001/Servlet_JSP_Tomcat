<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ittimfn.sample.tomcat.radio.OptionsEnum" %>
<%@ page import="static ittimfn.sample.tomcat.radio.IndexServlet.SELECT_KEY" %>
<%@ page import="static ittimfn.sample.tomcat.radio.IndexServlet.OPTIONS_KEY" %>
<%@ page import="static ittimfn.sample.tomcat.radio.IndexServlet.SELECTED_OPTION_KEY" %>
<%
  @SuppressWarnings("unchecked")
  List<OptionsEnum> options = (List<OptionsEnum>) request.getAttribute(OPTIONS_KEY);
  if (options == null || options.isEmpty()) {
    options = OptionsEnum.asList();
  }

  OptionsEnum selectedOption = (OptionsEnum) request.getAttribute(SELECTED_OPTION_KEY);
  if (selectedOption == null) {
    selectedOption = OptionsEnum.getDefault();
  }

  String selectedValue = selectedOption.getValue();
%>
<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Radio Selection</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css">
    <script defer src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6/js/all.min.js"></script>
  </head>

  <body class="has-background-light">
    <section class="hero is-fullheight">
      <div class="hero-body">
        <div class="container">
          <div class="columns is-centered">
            <div class="column is-11-tablet is-7-desktop is-6-widescreen">

              <!-- メインカード -->
              <div class="card">
                <header class="card-header has-background-primary">
                  <p class="card-header-title has-text-white">
                    <span class="icon mr-2">
                      <i class="fas fa-list"></i>
                    </span>
                    <span>Radio Selection</span>
                  </p>
                </header>

                <div class="card-content">
                  <!-- 説明文 -->
                  <div class="content mb-5">
                    <p class="subtitle is-6 has-text-grey-dark">
                      ラジオボタンから都市を選択してください
                    </p>
                  </div>

                  <!-- フォーム -->
                  <form method="post" id="radioForm" action="<%= request.getContextPath() %>/">
                    <div class="field">
                      <label class="label">
                        <span class="icon-text">
                          <span class="icon has-text-info">
                            <i class="fas fa-tags"></i>
                          </span>
                          <span>City</span>
                        </span>
                      </label>
                      <div class="control">
                        <% for (OptionsEnum option : options) { %>
                          <label class="radio is-flex is-align-items-center mb-2">
                            <input
                              type="radio"
                              name="<%= SELECT_KEY %>"
                              value="<%= option.getValue() %>"
                              <%= option.getValue().equals(selectedValue) ? "checked" : "" %>
                              onchange="this.form.submit()"
                            />
                            <span class="ml-2"><%= option.getLabel() %></span>
                          </label>
                        <% } %>
                      </div>
                      <p class="help has-text-grey">
                        <span class="icon-text">
                          <span class="icon is-small">
                            <i class="fas fa-info-circle"></i>
                          </span>
                          <span>選択すると自動的に送信されます</span>
                        </span>
                      </p>
                    </div>
                  </form>

                  <!-- 選択結果表示 -->
                  <% if (selectedValue != null && !selectedValue.isEmpty()) { %>
                  <div class="notification is-success is-light mt-5">
                    <div class="level is-mobile">
                      <div class="level-left">
                        <div class="level-item">
                          <span class="icon has-text-success mr-2">
                            <i class="fas fa-check-circle"></i>
                          </span>
                          <span>
                            <strong>選択された都市:</strong>
                            <%= selectedOption.getLabel() %> (<code><%= selectedOption.getValue() %></code>)
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                  <% } %>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </section>
  </body>
</html>
