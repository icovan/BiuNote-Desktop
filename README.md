# BiuNote Desktop (Tauri)

Windows 绿色版壳：打包现有 `web/app` + `web/alphatab`。

**正式包默认 API：`https://www.biunow.cn`**（必须与微信/Google 回调同域，登录才能同步回桌面）。本地调试再设 `BIUPRO_DESKTOP_LOCAL=1` 或 `BIUPRO_API_ORIGIN`。

## 前置

- Node.js 18+
- Rust stable（`rustup`）
- Visual Studio 2022（含 C++ 桌面开发 / MSVC）
- WebView2 Runtime（Win10/11 通常已自带）

## 开发（连本地后端）

```powershell
cd desktop
npm install
$env:BIUPRO_DESKTOP_LOCAL = "1"   # API → http://127.0.0.1:8091
# 后端需在 8091 运行
npm run dev
```

`npm run dev` 会先打包 `dist-ui`，再由 Tauri 内置静态服务（默认 `http://127.0.0.1:1430`）加载工作台。

## 构建绿色版（连线上，可微信登录）

版本号与服务端 `configs/config.yaml` 的 `app.version` **共用**，构建时会同步到 Tauri，并复制出 `BiuNote-Vx.x.x.exe`。

```powershell
cd desktop
# 默认已指向 https://www.biunow.cn；可覆盖：
# $env:BIUPRO_API_ORIGIN = "https://www.biunow.cn"
npm run build
# 产物：desktop/src-tauri/target/release/BiuNote.exe
# 以及：desktop/src-tauri/target/release/BiuNote-V{app.version}.exe
```

登录流程（与 Cursor 类似）：桌面打开系统浏览器 → `/app/desktop-auth.html`  
- 网页已登录：直接绑定并同步到桌面  
- 未登录：微信/Google 授权后同步到桌面  

**线上需已部署** 含 `POST /api/v1/auth/desktop/bind` 与 `desktop-auth.html` 的后端/静态资源。

发版写入「版本记录」弹窗（数据库）时，在仓库根目录：

```powershell
# 先改 configs/config.yaml 的 app.version，再 commit，然后：
go run ./cmd/changelog
# 说明默认取 git commit -m 的标题；无说明则只记版本号
```


产物：

| 路径 | 说明 |
| --- | --- |
| `src-tauri/target/release/biunote.exe` | **单文件绿色版**（资源已嵌入，拷走即可） |

安装包（NSIS）默认关闭（下载易超时）。需要时把 `src-tauri/tauri.conf.json` 里 `bundle.active` 改为 `true` 再 `npm run build`。

把 `biunote.exe` 拷走即可运行；需能访问配置的 API（默认本机 8091）。

## 已知限制（MVP）

- OAuth 回调仍走网站 `public_url`，桌面端请先用邮箱登录
- 编译 / 登录 / 云谱依赖后端，非完全离线
