# 画像管理システム

画像をH2データベースに保存・表示・削除できるTomcat Webアプリケーションです。

## 機能

- 画像のアップロード（PNG, JPG, GIF対応、最大10MB）
- データベースに画像をBLOBとして保存
- 画像の一覧表示（カード形式）
- 画像の表示（別ウィンドウ）
- 画像の削除（確認モーダル付き）
- Bulma.cssを使用したモダンなUI

## 技術スタック

- **Java**: 1.8
- **サーブレット API**: 4.0.1
- **データベース**: H2 Database 2.2.224 (埋め込みモード)
- **CSSフレームワーク**: Bulma.css 0.9.4
- **ロギング**: Log4j2 2.20.0
- **その他**: Lombok, Commons FileUpload, JSTL

## プロジェクト構造

```
src/
├── main/
│   ├── java/ittimfn/sample/tomcat/blob/
│   │   ├── DatabaseInitListener.java    # データベース初期化リスナー
│   │   ├── DatabaseUtil.java            # データベース接続ユーティリティ
│   │   ├── Image.java                   # 画像エンティティ
│   │   ├── ImageUploadServlet.java      # 画像アップロード・一覧表示
│   │   ├── ImageViewServlet.java        # 画像表示
│   │   └── ImageDeleteServlet.java      # 画像削除
│   └── webapp/
│       └── WEB-INF/
│           ├── images.jsp               # 画像管理画面
│           └── web.xml                  # Web設定
└── ...
```

## ビルドと実行

### 1. ビルド

```bash
mvn clean package
```

### 2. Tomcatへデプロイ

生成されたWARファイルをTomcatのwebappsディレクトリにコピーします：

```bash
cp target/radio.war $CATALINA_HOME/webapps/
```

### 3. アクセス

ブラウザで以下のURLにアクセスします：

```
http://localhost:8080/radio/images
```

## データベース

- **エンジン**: H2 Database（埋め込みモード）
- **ファイル場所**: `~/imagedb.mv.db`
- **接続URL**: `jdbc:h2:~/imagedb`
- **ユーザー**: `sa`
- **パスワード**: （空）

### テーブル構造

```sql
CREATE TABLE images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    content_type VARCHAR(100) NOT NULL,
    image_data BLOB NOT NULL,
    file_size BIGINT NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## エンドポイント

| URL | メソッド | 説明 |
|-----|---------|------|
| `/images` | GET | 画像一覧の表示 |
| `/images` | POST | 画像のアップロード |
| `/image?id={id}` | GET | 画像の表示 |
| `/delete-image` | POST | 画像の削除 |

## 使用方法

1. **画像をアップロード**
   - 「ファイルを選択」ボタンをクリック
   - 画像ファイル（PNG, JPG, GIF）を選択
   - 「アップロード」ボタンをクリック

2. **画像を表示**
   - カードの「表示」リンクをクリックすると新しいタブで画像が表示されます

3. **画像を削除**
   - カードの「削除」リンクをクリック
   - 確認モーダルで「削除する」ボタンをクリック

## 注意事項

- アップロード可能なファイルサイズは最大10MBです
- 対応している画像形式はPNG, JPG, GIFのみです
- データベースはアプリケーション起動時に自動的に初期化されます
- 画像はデータベースにBLOBとして保存されます

## ライセンス

このプロジェクトはサンプルアプリケーションです。
