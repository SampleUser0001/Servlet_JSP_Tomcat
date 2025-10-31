<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Pulldown Selection</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css">
    <script defer src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6/js/all.min.js"></script>
    <script>
        function submit_form() {
            const selectedValue = document.getElementById("sample_select").value;
            }
    </script>
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
                    <span>Pulldown Selection</span>
                  </p>
                </header>

                <div class="card-content">
                  <!-- 説明文 -->
                  <div class="content mb-5">
                    <p class="subtitle is-6 has-text-grey-dark">
                      カテゴリを選択してください
                    </p>
                  </div>

                  <!-- フォーム -->
                  <form method="post" id="pulldownForm">
                    <div class="field">
                      <label class="label" for="sample_select">
                        <span class="icon-text">
                          <span class="icon has-text-info">
                            <i class="fas fa-tags"></i>
                          </span>
                          <span>Subject</span>
                        </span>
                      </label>
                      <div class="control has-icons-left">
                        <div class="select is-fullwidth is-medium">
                          <select id="sample_select" name="options" onchange="this.form.submit()">
                            <option value="">項目を選択してください</option>
                            <option value="1">Option 1</option>
                            <option value="2">Option 2</option>
                            <option value="3">Option 3</option>
                          </select>
                        </div>
                        <span class="icon is-left">
                          <i class="fas fa-chevron-down"></i>
                        </span>
                      </div>
                      <p class="help has-text-grey">
                        <span class="icon-text">
                          <span class="icon is-small">
                            <i class="fas fa-info-circle"></i>
                          </span>
                          <span>項目を選択すると自動的に送信されます</span>
                        </span>
                      </p>
                    </div>
                  </form>

                  <!-- 選択結果表示 -->
                  <%
                    Object selected = request.getAttribute("sample_select");
                    if (selected != null && !selected.toString().isEmpty()) {
                  %>
                  <div class="notification is-success is-light mt-5">
                    <div class="level is-mobile">
                      <div class="level-left">
                        <div class="level-item">
                          <span class="icon has-text-success mr-2">
                            <i class="fas fa-check-circle"></i>
                          </span>
                          <span><strong>選択された値:</strong> <%= selected %></span>
                        </div>
                      </div>
                    </div>
                  </div>
                  <%
                    }
                  %>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </section>
  </body>
</html>
