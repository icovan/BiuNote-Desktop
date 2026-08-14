# BiuNote Desktop

**最简单语法，最酷曲谱。** 编码 / 指令打谱，几分钟做出能播放、能改的吉他弹唱谱。

- 官网 / 在线打谱：https://www.biunow.cn
- GitHub（开源桌面壳）：https://github.com/icovan/BiuNote-Desktop
- Gitee（完整产品私有仓）：https://gitee.com/zaokework/biu-note

本仓库开源的是 **Tauri 桌面壳（MIT）**。登录、云谱、编译、支付在官方在线服务；**服务端源码不在 GitHub**。

正式包默认 API：`https://www.biunow.cn`

---

## 两个仓库，不要混

| 仓库 | 地址 | 推什么 |
| --- | --- | --- |
| **Gitee（日常）** | https://gitee.com/zaokework/biu-note.git | 整个 `biu-pro`（后端 + Web + desktop） |
| **GitHub（开源）** | https://github.com/icovan/BiuNote-Desktop | **只推 `desktop/` 目录** |

开发、改代码、提交，始终在现在的 `biu-pro` 里做，**不要再复制到 `E:\open` 之类的目录**。

---

## 1. 日常：改完推 Gitee

在 **biu-pro 仓库根目录**（不要在 `desktop` 里 push 整个产品）：

```powershell
git add .
git commit -m "说明这次改了什么"
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/push-main.ps1
```

只会推到 Gitee `zaokework/biu-note`。服务器更新继续用 `bash scripts/server-update.sh`。

---

## 2. 发布开源桌面：推 GitHub

`desktop/` 有未提交改动时，先走上面第 1 步提交。然后 **就在 desktop 目录**：

```powershell
cd desktop
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/push-github.ps1
```

脚本会把 `desktop/` 推到 https://github.com/icovan/BiuNote-Desktop （浏览器登录账号必须是 **icovan**，或对该仓有写权限）。

第一次如果提示仓库为空，跑完上面这条即可，不要再 `git push -u github main` 去推整个 biu-pro。

---

## 开发与打包

需要：Node.js 18+、Rust、VS2022（C++ 桌面 / MSVC）、WebView2。

连本地后端（8091 已启动）：

```powershell
cd desktop
npm install
$env:BIUPRO_DESKTOP_LOCAL = "1"
npm run dev
```

打绿色版（连官网）：

```powershell
cd desktop
npm run build
```

产物：`src-tauri/target/release/BiuNote.exe`，以及带版本号的 `BiuNote-V*.exe`。

---

## License

MIT。收费的是完整业务源码授权，不是对本桌面壳再收费。套餐见官网。
