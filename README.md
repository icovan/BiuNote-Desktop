# BiuNote Desktop

**最简单语法，最酷曲谱。**  
用 BiuNote 编码 / 指令，几分钟做出能播放、能修改的吉他弹唱谱。

[官网 / 在线打谱](https://www.biunow.cn) · [下载桌面版](https://www.biunow.cn) · GitHub · Gitee

<!-- 将截图放到 docs/screenshots/ 后取消下一行注释 -->
<!-- ![工作台全貌](docs/screenshots/01-hero-workspace.png) -->

> 本仓库开源的是 **桌面客户端壳（Tauri，MIT）**。  
> 登录、云谱、编译、支付由官方在线服务提供；**完整服务端源码不在本仓库**。

正式包默认 API：`https://www.biunow.cn`（需与微信 / Google 回调同域，登录才能同步回桌面）。

---

## 为什么是 BiuNote？

不是对标 Guitar Pro 的「精修排版」，而是：**从想法到可播谱面，以分钟计。**

| 你要的 | BiuNote 怎么做 |
| --- | --- |
| 快出谱 | 左边写编码 / 指令，右边实时渲染 |
| 能改 | 生成的是可编辑 BiuNote，不是黑盒 |
| 弹唱够用 | 六线 · 简谱 · 五线 · 弹唱组合 |
| 可带走 | 试听；Pro 可导出 PDF / GP / MIDI |

<!-- ![实时预览](docs/screenshots/02-live-preview.gif) -->

---

## 核心能力

### 1. 编码打谱：极简语法 → 专业谱面

弦位用 `a`–`f`，小节用 `|`，和弦名、扫弦、闷音等用短语法写出。  
新手跟着应用内引导，几分钟就能完成第一小节。

```text
title: Demo
tempo: 96
[V:1]
"Am" a0 c2 e0 a0 | "G"  V[axfx] |
```

卡住时打开右上角 **语法** 表，或应用内手册。

### 2. 指令成谱：结构 × 和弦 × 节奏型

选段落结构、填和弦、选节奏型 → 一键生成 **可继续手改** 的 BiuNote。  
适合「先出骨架，再精修 10%–20%」。

<!-- ![指令打谱](docs/screenshots/03-command-arrange.png) -->

### 3. 多种谱面显示

同一份源码，可切换六线 / 简谱 / 五线 / 弹唱组合，并调节布局与显示元素。

<!-- ![谱种展示](docs/screenshots/04-notation-styles.png) -->

### 4. 试听与工具

内置播放、和弦查找、调音器、语法速查与使用手册，降低上手成本。

<!-- ![播放](docs/screenshots/05-playback.png) -->
<!-- ![和弦 / 调音](docs/screenshots/06-chords-tuner.png) -->

### 5. 云端曲谱 · GP 导入 · 导出（账号 / Pro）

- 登录后云端保存「我的曲谱」
- Guitar Pro 导入为可编辑 BiuNote
- 导出 PDF / GP / MIDI（以官网会员能力为准）

<!-- ![云谱](docs/screenshots/09-cloud-scores.png) -->
<!-- ![GP 导入](docs/screenshots/07-gp-import.png) -->
<!-- ![导出](docs/screenshots/08-export.png) -->

---

## 桌面版（本仓库）

独立窗口运行的绿色版客户端，打包现有工作台 UI，默认连接官方 API。

<!-- ![桌面壳](docs/screenshots/10-desktop-shell.png) -->

| 开源（本仓库） | 不开源 |
| --- | --- |
| Tauri 壳、桥接脚本、打包与图标 | Go 后端、支付、管理 / 代理后台、完整业务 |

截图命名与拍摄说明见 [`docs/screenshots/SHOTLIST.md`](docs/screenshots/SHOTLIST.md)。

### 环境要求

- Node.js 18+
- Rust stable（`rustup`）
- Visual Studio 2022（含 C++ 桌面开发 / MSVC）
- WebView2 Runtime（Win10/11 通常已自带）

### 开发（连本地后端）

```powershell
cd desktop
npm install
$env:BIUPRO_DESKTOP_LOCAL = "1"   # API → http://127.0.0.1:8091
# 后端需在 8091 运行
npm run dev
```

`npm run dev` 会先打包 `dist-ui`，再由 Tauri 内置静态服务（默认 `http://127.0.0.1:1430`）加载工作台。

### 构建绿色版（连线上）

版本号与服务端 `configs/config.yaml` 的 `app.version` **共用**，构建时会同步到 Tauri，并复制出 `BiuNote-Vx.x.x.exe`。

```powershell
cd desktop
# 默认已指向 https://www.biunow.cn；可覆盖：
# $env:BIUPRO_API_ORIGIN = "https://www.biunow.cn"
npm run build
# 产物：src-tauri/target/release/BiuNote.exe
# 以及：src-tauri/target/release/BiuNote-V{app.version}.exe
```

登录流程：桌面打开系统浏览器 → `/app/desktop-auth.html`

- 网页已登录：直接绑定并同步到桌面
- 未登录：微信 / Google 授权后同步到桌面

**线上需已部署** 含 `POST /api/v1/auth/desktop/bind` 与 `desktop-auth.html` 的后端 / 静态资源。

| 路径 | 说明 |
| --- | --- |
| `src-tauri/target/release/biunote.exe` | 单文件绿色版（资源已嵌入，拷走即可） |

安装包（NSIS）默认关闭。需要时把 `src-tauri/tauri.conf.json` 里 `bundle.active` 改为 `true` 再 `npm run build`。

### 已知限制（MVP）

- OAuth 回调仍走网站 `public_url`；桌面端请按产品流程完成浏览器登录绑定
- 编译 / 登录 / 云谱依赖后端，非完全离线

---

## 相关链接

- 官网 / 在线打谱：https://www.biunow.cn
- 应用内手册与语法速查（打开工作台即可）
- Issue：欢迎反馈桌面壳相关问题（构建、打包、登录绑定等）

---

## 在线 Pro 与商业源码授权

桌面壳 **MIT 免费**。若你需要完整能力或私有部署：

- **在线 Pro**：月付 / 年付 / 终身 → 以 [官网套餐](https://www.biunow.cn) 为准  
- **全栈源码授权**（含服务端，可私有部署）：

| 档位 | 适合 | 参考价 |
| --- | --- | --- |
| 个人授权 | 本人部署，不可转售 / 不可做公开 SaaS | ¥2,999 |
| 团队授权 | 团队内部 + 一次部署协助 | ¥6,999 |
| 商业授权 | 品牌替换、商用上线（非独占） | ¥19,999 |

价格与交付范围以沟通确认为准。咨询请通过 [官网](https://www.biunow.cn) 留言。

> 收费的是完整业务源码与授权，不是对本 MIT 桌面仓库再收费。

---

## License

MIT（开源仓根目录放置 `LICENSE` 文件）。
