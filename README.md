# BiuNote Desktop

**最简单语法，最酷曲谱。**

用 BiuNote 编码 / 指令，几分钟做出能播放、能修改的吉他弹唱谱。

[官网 / 在线打谱](https://www.biunow.cn) · [下载桌面版](https://www.biunow.cn) · [GitHub](https://github.com/icovan/BiuNote-Desktop) · [Gitee](https://gitee.com/zaokework/biunote-desktop)

<!-- 将截图放到 docs/screenshots/ 后取消注释 -->
<!-- ![工作台](docs/screenshots/01-hero-workspace.png) -->

---

## 这是什么

独立窗口运行的 **桌面客户端（Tauri，MIT）**，打包 BiuNote 工作台，默认连接官方服务 `https://www.biunow.cn`。

| 本仓库有 | 本仓库没有 |
| --- | --- |
| 桌面壳、打包脚本、图标 | 服务端、支付、管理后台、完整业务源码 |

登录、云谱、编译、会员能力由官方在线服务提供。需要私有部署或二次商用，见文末授权。

---

## 为什么用 BiuNote

不是对标 Guitar Pro 的精修排版，而是：**从想法到可播谱面，以分钟计。**

- **编码打谱**：弦位 `a`–`f`，小节 `|`，和弦与技法用短语法写出
- **指令成谱**：结构 × 和弦 × 节奏型 → 生成可继续手改的谱
- **多种谱面**：六线 / 简谱 / 五线 / 弹唱组合
- **能带走**：试听；Pro 可导出 PDF / GP / MIDI

```text
title: Demo
tempo: 96
[V:1]
"Am" a0 c2 e0 a0 | "G"  V[axfx] |
```

卡住时打开应用内 **语法** 与手册。

---

## 从源码运行

需要 Node.js 18+、Rust、Windows 下 VS2022（C++ 桌面 / MSVC）、WebView2。

```powershell
npm install
npm run dev
```

默认连接官网 API。连本地后端时：

```powershell
$env:BIUPRO_DESKTOP_LOCAL = "1"   # → http://127.0.0.1:8091
npm run dev
```

打包绿色版：

```powershell
npm run build
```

产物在 `src-tauri/target/release/`（`BiuNote.exe` 与带版本号的副本）。

---

## 在线 Pro 与源码授权

桌面壳 **MIT，免费**。账号、云同步、支付和 **完整服务端** 不在本仓库。

- **在线打谱 / Pro**：月付 · 年付 · 终身 → [官网套餐](https://www.biunow.cn)
- **全栈源码授权**（含服务端，可私有部署）：

| 档位 | 适合 | 参考价 |
| --- | --- | --- |
| 个人授权 | 本人部署，不可转售 / 不可做公开 SaaS | ¥2,999 |
| 团队授权 | 团队内部 + 一次部署协助 | ¥6,999 |
| 商业授权 | 品牌替换、商用上线（非独占） | ¥19,999 |

价格与交付范围以沟通为准。咨询请通过 [官网留言](https://www.biunow.cn)。

> 收费的是完整业务源码与授权，不是对本 MIT 桌面仓库再收费。

---

## License

MIT
