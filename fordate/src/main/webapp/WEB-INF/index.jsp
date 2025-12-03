<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Date</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@1.0.4/css/bulma.min.css">
    <script defer src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6/js/all.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

    <script>
      $(document).ready(function() {
        $('#send').click(() => {
          if( $('#d').val() ) {
            if(!$('#d').val()) {
              alert('hogehoge');
              $('#d').eq(0).forcus();
              return false;
            }
          }
          return true;
        });
      })
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
                    <span>Date Checker</span>
                  </p>
                </header>

                <div class="card-content">
                  <!-- 説明文 -->
                  <div class="content mb-5">
                    <p class="subtitle is-6 has-text-grey-dark">
                      日付を入力してください
                    </p>
                  </div>

                  <!-- フォーム -->
                  <form method="post">
                    <div class="field">
                      <label class="label" for="sample_select">
                        <span class="icon-text">
                          <span class="icon has-text-info">
                            <i class="fas fa-tags"></i>
                          </span>
                          <span>Date</span>
                        </span>
                      </label>
                      <div class="control has-icons-left">
                        <div class="select is-fullwidth is-medium">
                          <input type="date" id="d" name="d" value='<%=request.getAttribute("d")%>' />
                        </div>
                      </div>

                      <button type="submit" class="button is-primary" id="send" formaction="<%= request.getContextPath() %>/" >送信</button>

                    </div>
                  </form>

                </div>
              </div>

            </div>
          </div>
        </div>
      </div>
    </section>
  </body>
</html>
