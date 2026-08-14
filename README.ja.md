# BiuNote Desktop

[English](README.md) | [简体中文](README.zh-CN.md) | **日本語** | [한국어](README.ko.md)

**いちばん簡単な記譜。いちばんかっこいいスコア。**

BiuNote のコード／コマンドで、数分で再生・編集できるギター伴奏譜ができます。

[公式サイト / オンライン編集](https://www.biunow.cn) · [ダウンロード](https://www.biunow.cn) · [GitHub](https://github.com/icovan/BiuNote-Desktop) · [Gitee](https://gitee.com/zaokework/biunote-desktop)

<!-- Uncomment after adding docs/screenshots/01-hero-workspace.png -->
<!-- ![Workbench](docs/screenshots/01-hero-workspace.png) -->

---

## このリポジトリについて

BiuNote ワークベンチを包んだ **デスクトップクライアント（Tauri、MIT）** です。公式 API `https://www.biunow.cn` に接続します。

| 含まれるもの | 含まれないもの |
| --- | --- |
| デスクトップシェル、ビルドスクリプト、アイコン | サーバー、決済、管理画面、製品本体のソース |

ログイン、クラウド譜面、コンパイル、Pro 機能は公式のオンラインサービス側です。セルフホストや商用利用は、末尾のライセンスを見てください。

---

## なぜ BiuNote か

Guitar Pro のような精密な浄書が目的ではありません。**思いつき → 再生できる譜面を、分単位で。**

- **コードで記譜** — 弦は `a`–`f`、小節は `|`、コードと技法は短いトークン
- **コマンド成譜** — 構成 × コード × リズムパターン → あとから手直しできる譜面
- **表示** — TAB / 数字譜 / 五線 / 弾き語りミックス
- **持ち出せる** — 再生。Pro は PDF / Guitar Pro / MIDI 書き出し

```text
title: Demo
tempo: 96
[V:1]
"Am" a0 c2 e0 a0 | "G"  V[axfx] |
```

詰まったらアプリ内の **構文** とマニュアルを開いてください。

---

## ソースから実行

Node.js 18+、Rust、Windows では VS2022（C++ デスクトップ / MSVC）、WebView2 が必要です。

```powershell
npm install
npm run dev
```

既定では本番 API に接続します。ローカルバックエンドの場合：

```powershell
$env:BIUPRO_DESKTOP_LOCAL = "1"   # → http://127.0.0.1:8091
npm run dev
```

ポータブル版のビルド：

```powershell
npm run build
```

成果物は `src-tauri/target/release/`（`BiuNote.exe` とバージョン付きコピー）。

---

## Pro とソースライセンス

デスクトップシェルは **MIT で無料** です。アカウント、クラウド同期、決済、**サーバー本体** はこのリポジトリにありません。

- **オンライン編集 / Pro** — 月額・年額・買い切り → [料金](https://www.biunow.cn)
- **フルスタックソースライセンス**（サーバー含む、セルフホスト可）：

| プラン | 対象 | 参考価格 |
| --- | --- | --- |
| 個人 | 本人のデプロイ。転売・公開 SaaS 不可 | ¥2,999 |
| チーム | チーム内利用 + 導入支援 1 回 | ¥6,999 |
| 商用 | ブランド差し替え・商用公開（非独占） | ¥19,999 |

範囲と価格は相談のうえ確定します。[公式サイト](https://www.biunow.cn) からご連絡ください。

> 対価は製品本体のソースとライセンスであり、この MIT デスクトップ倉庫ではありません。

---

## License

MIT
