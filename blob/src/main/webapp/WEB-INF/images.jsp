<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>画像管理システム</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .image-card {
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .image-card .card-image {
            flex-shrink: 0;
            height: 250px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f5f5f5;
        }
        .image-card .card-image img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }
        .image-card .card-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        .image-card .card-footer {
            margin-top: auto;
        }
        .file-name {
            max-width: 250px;
            display: inline-block;
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <section class="hero is-primary">
        <div class="hero-body">
            <div class="container">
                <h1 class="title">
                    <i class="fas fa-images"></i> 画像管理システム
                </h1>
                <p class="subtitle">
                    画像をデータベースに保存・表示するアプリケーション
                </p>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <!-- Success/Error Messages -->
            <c:if test="${not empty param.success}">
                <div class="notification is-success is-light">
                    <button class="delete" onclick="this.parentElement.remove()"></button>
                    <c:choose>
                        <c:when test="${param.success == 'deleted'}">
                            画像が正常に削除されました。
                        </c:when>
                        <c:otherwise>
                            操作が正常に完了しました。
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="notification is-success is-light">
                    <button class="delete" onclick="this.parentElement.remove()"></button>
                    ${success}
                </div>
            </c:if>

            <c:if test="${not empty param.error}">
                <div class="notification is-danger is-light">
                    <button class="delete" onclick="this.parentElement.remove()"></button>
                    <c:choose>
                        <c:when test="${param.error == 'invalid_id'}">
                            無効な画像IDです。
                        </c:when>
                        <c:when test="${param.error == 'not_found'}">
                            画像が見つかりませんでした。
                        </c:when>
                        <c:when test="${param.error == 'delete_failed'}">
                            画像の削除に失敗しました。
                        </c:when>
                        <c:otherwise>
                            エラーが発生しました。
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="notification is-danger is-light">
                    <button class="delete" onclick="this.parentElement.remove()"></button>
                    ${error}
                </div>
            </c:if>

            <!-- Upload Form -->
            <div class="box">
                <h2 class="title is-4">
                    <i class="fas fa-upload"></i> 画像をアップロード
                </h2>
                <form action="${pageContext.request.contextPath}/images" method="post" enctype="multipart/form-data">
                    <div class="field">
                        <div class="file has-name is-fullwidth">
                            <label class="file-label">
                                <input class="file-input" type="file" name="image" id="fileInput" accept="image/*" required>
                                <span class="file-cta">
                                    <span class="file-icon">
                                        <i class="fas fa-upload"></i>
                                    </span>
                                    <span class="file-label">
                                        ファイルを選択...
                                    </span>
                                </span>
                                <span class="file-name" id="fileName">
                                    ファイルが選択されていません
                                </span>
                            </label>
                        </div>
                        <p class="help">対応形式: PNG, JPG, GIF (最大10MB)</p>
                    </div>

                    <div class="field">
                        <div class="control">
                            <button type="submit" class="button is-primary is-fullwidth">
                                <span class="icon">
                                    <i class="fas fa-cloud-upload-alt"></i>
                                </span>
                                <span>アップロード</span>
                            </button>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Images Gallery -->
            <div class="box">
                <h2 class="title is-4">
                    <i class="fas fa-th"></i> 画像一覧
                    <span class="tag is-info is-light is-medium ml-2">${images.size()}枚</span>
                </h2>

                <c:choose>
                    <c:when test="${empty images}">
                        <div class="notification is-info is-light">
                            <i class="fas fa-info-circle"></i>
                            画像がまだアップロードされていません。
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="columns is-multiline">
                            <c:forEach var="image" items="${images}">
                                <div class="column is-one-third">
                                    <div class="card image-card">
                                        <div class="card-image">
                                            <figure class="image">
                                                <img src="${pageContext.request.contextPath}/image?id=${image.id}"
                                                     alt="${image.name}"
                                                     loading="lazy">
                                            </figure>
                                        </div>
                                        <div class="card-content">
                                            <div class="content">
                                                <p class="subtitle is-6 mb-2">
                                                    <i class="fas fa-file-image"></i>
                                                    <strong class="has-text-weight-semibold">${image.name}</strong>
                                                </p>
                                                <p class="is-size-7">
                                                    <span class="tag is-light">
                                                        <i class="fas fa-calendar"></i>
                                                        <fmt:formatDate value="${image.uploadedAt}" pattern="yyyy/MM/dd HH:mm:ss"/>
                                                    </span>
                                                </p>
                                                <p class="is-size-7">
                                                    <span class="tag is-light">
                                                        <i class="fas fa-hdd"></i>
                                                        <fmt:formatNumber value="${image.fileSize / 1024}" pattern="#,##0.0"/> KB
                                                    </span>
                                                </p>
                                                <p class="is-size-7">
                                                    <span class="tag is-light">
                                                        <i class="fas fa-file-code"></i>
                                                        ${image.contentType}
                                                    </span>
                                                </p>
                                            </div>
                                        </div>
                                        <footer class="card-footer">
                                            <a href="${pageContext.request.contextPath}/image?id=${image.id}"
                                               class="card-footer-item has-text-link"
                                               target="_blank">
                                                <span class="icon">
                                                    <i class="fas fa-external-link-alt"></i>
                                                </span>
                                                <span>表示</span>
                                            </a>
                                            <a href="#"
                                               class="card-footer-item has-text-danger"
                                               onclick="deleteImage(${image.id}, '${image.name}'); return false;">
                                                <span class="icon">
                                                    <i class="fas fa-trash"></i>
                                                </span>
                                                <span>削除</span>
                                            </a>
                                        </footer>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <footer class="footer">
        <div class="content has-text-centered">
            <p>
                <strong>画像管理システム</strong> - H2データベース + Tomcat + Bulma.css
            </p>
        </div>
    </footer>

    <!-- Delete Confirmation Modal -->
    <div class="modal" id="deleteModal">
        <div class="modal-background" onclick="closeDeleteModal()"></div>
        <div class="modal-card">
            <header class="modal-card-head">
                <p class="modal-card-title">削除の確認</p>
                <button class="delete" aria-label="close" onclick="closeDeleteModal()"></button>
            </header>
            <section class="modal-card-body">
                <p>本当にこの画像を削除しますか？</p>
                <p class="has-text-weight-semibold mt-3" id="deleteImageName"></p>
                <p class="has-text-danger mt-3">
                    <i class="fas fa-exclamation-triangle"></i>
                    この操作は取り消せません。
                </p>
            </section>
            <footer class="modal-card-foot">
                <form id="deleteForm" method="post" action="${pageContext.request.contextPath}/delete-image">
                    <input type="hidden" name="id" id="deleteImageId">
                    <button type="submit" class="button is-danger">
                        <span class="icon">
                            <i class="fas fa-trash"></i>
                        </span>
                        <span>削除する</span>
                    </button>
                </form>
                <button class="button" onclick="closeDeleteModal()">キャンセル</button>
            </footer>
        </div>
    </div>

    <script>
        // File input display
        document.getElementById('fileInput').addEventListener('change', function(e) {
            const fileName = e.target.files[0] ? e.target.files[0].name : 'ファイルが選択されていません';
            document.getElementById('fileName').textContent = fileName;
        });

        // Delete confirmation modal
        function deleteImage(id, name) {
            document.getElementById('deleteImageId').value = id;
            document.getElementById('deleteImageName').textContent = name;
            document.getElementById('deleteModal').classList.add('is-active');
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').classList.remove('is-active');
        }

        // Close modal with ESC key
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeDeleteModal();
            }
        });
    </script>
</body>
</html>
