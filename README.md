# BiuNote Desktop

**English** | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

**The simplest syntax. The coolest charts.**

Write BiuNote code or commands and get a playable, editable guitar accompaniment chart in minutes.

[Website / online editor](https://www.biunow.cn) · [Download](https://www.biunow.cn) · [GitHub](https://github.com/icovan/BiuNote-Desktop) · [Gitee](https://gitee.com/zaokework/biunote-desktop)

<!-- Uncomment after adding docs/screenshots/01-hero-workspace.png -->
<!-- ![Workbench](docs/screenshots/01-hero-workspace.png) -->

---

## What this repo is

A **desktop client** (Tauri, MIT) that wraps the BiuNote workbench and talks to the official API at `https://www.biunow.cn`.

| In this repo | Not in this repo |
| --- | --- |
| Desktop shell, build scripts, icons | Server, payments, admin, full product source |

Sign-in, cloud scores, compile, and Pro features run on BiuNote’s hosted service. For self-hosting or commercial use, see licensing below.

---

## Why BiuNote

Not a Guitar Pro clone for pixel-perfect engraving. The point is **idea → playable chart, in minutes**.

- **Code the chart** — strings `a`–`f`, bars `|`, chords and techniques as short tokens
- **Command mode** — form × chords × rhythm pattern → a chart you can still edit
- **Views** — tab, numbered notation, staff, or mixed accompaniment
- **Take it with you** — playback; Pro export to PDF / Guitar Pro / MIDI

```text
title: Demo
tempo: 96
[V:1]
"Am" a0 c2 e0 a0 | "G"  V[axfx] |
```

If you get stuck, open **Syntax** and the in-app manual.

---

## Run from source

You need Node.js 18+, Rust, Visual Studio 2022 (C++ desktop / MSVC) on Windows, and WebView2.

```powershell
npm install
npm run dev
```

This talks to the production API by default. For a local backend:

```powershell
$env:BIUPRO_DESKTOP_LOCAL = "1"   # → http://127.0.0.1:8091
npm run dev
```

Portable build:

```powershell
npm run build
```

Output: `src-tauri/target/release/` (`BiuNote.exe` and a versioned copy).

---

## Pro and source license

The desktop shell is **MIT and free**. Accounts, cloud sync, payments, and the **full server** are not in this repository.

- **Online editor / Pro** — monthly, yearly, or lifetime → [pricing](https://www.biunow.cn)
- **Full-stack source license** (includes server, self-hosting):

| Tier | For | From |
| --- | --- | --- |
| Personal | Your own deploy; no resale / no public SaaS | ¥2,999 |
| Team | Internal team + one setup assist | ¥6,999 |
| Commercial | Branding and commercial launch (non-exclusive) | ¥19,999 |

Scope and price are confirmed in conversation. Reach us via [the website](https://www.biunow.cn).

> You pay for the full product source and license — not for this MIT desktop repo.

---

## License

MIT
