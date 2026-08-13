# BiuNote 桌面端开源发布手册（GitHub + Gitee）

> 目标：只开源 **桌面端**，后端保持私有。  
> 适合：第一次在 GitHub / Gitee 建开源仓库，并两边同步。

---

## 0. 开源范围（先想清楚）

| 开源（公开） | 不开源（私有） |
| --- | --- |
| `desktop/`（Tauri 壳、桥接脚本、图标） | Go 后端 `cmd/` `internal/` |
| 构建说明、开源协议、Issue 模板 | `configs/`、密钥、数据库、支付配置 |
| （可选）桌面用到的前端静态资源副本 | 管理后台 / 代理后台 |

**建议：** 单独建一个公开仓库（例如 `biunote-desktop`），不要把整个 `biu-pro` 私有仓直接改公开。

默认 API 指向你的线上域名即可引流；仓库里不要写内网地址、密钥、后台路径。

---

## 1. 选开源协议（推荐 MIT）

个人/小团队引流桌面端，优先 **MIT**：短、好懂、商业友好。

| 协议 | 特点 | 适合 |
| --- | --- | --- |
| **MIT** | 很宽松，可商用、可改、可闭源衍生 | **推荐** |
| Apache-2.0 | 类似 MIT，多专利条款 | 更正式一点 |
| GPL-3.0 | 传染性较强，衍生也要开源 | 一般不适合引流壳 |

协议文件名固定为仓库根目录的 `LICENSE`（无后缀）。

MIT 正文模板（把年份和名字改成你的）：

```text
MIT License

Copyright (c) 2026 BiuNote Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 2. 在 GitHub 创建公开仓库

1. 打开 [https://github.com/new](https://github.com/new)（需先登录）。
2. 填写：
   - **Repository name**：`biunote-desktop`（可自定）
   - **Description**：例如 `BiuNote desktop client (Tauri) — open source shell`
   - **Public**
3. **不要**勾选：
   - Add a README
   - Add .gitignore
   - Choose a license  
   （本地初始化后再推，避免首推冲突。）
4. 点 **Create repository**。
5. 记下地址，例如：
   - HTTPS：`https://github.com/你的用户名/biunote-desktop.git`
   - SSH：`git@github.com:你的用户名/biunote-desktop.git`

仓库 Settings 里可选：

- **About → Website**：填官网 `https://www.biunow.cn`
- **Topics**：`tauri` `desktop` `music` `guitar` `opensource`

---

## 3. 在 Gitee 创建公开仓库

1. 打开 [https://gitee.com/projects/new](https://gitee.com/projects/new)（需先登录）。
2. 填写：
   - **仓库名称**：`biunote-desktop`（建议与 GitHub 同名）
   - **路径**：一般与名称相同
   - **开源**：选 **公开**
   - **开源许可协议**：选 **MIT License**（若页面有选项；没有就本地放 `LICENSE`）
3. **不要**勾选「使用 Readme 文件初始化仓库」（同样避免首推冲突）。
4. 点创建，记下地址，例如：
   - HTTPS：`https://gitee.com/你的用户名/biunote-desktop.git`
   - SSH：`git@gitee.com:你的用户名/biunote-desktop.git`

Gitee 额外建议：

- 仓库主页填官网链接  
- 语言选「其他」或按实际标注  
- 若要上 Gitee 推荐/搜索，完善简介与 README 截图

---

## 4. 本地准备开源目录（从现有 biu-pro 抽出）

在 PowerShell 中执行（路径按你的机器改）：

```powershell
# 1) 新建干净目录（不要放在私有仓里面直接改公开）
mkdir E:\open\biunote-desktop
cd E:\open\biunote-desktop

# 2) 复制桌面端源码（不要复制 target / node_modules / dist-ui）
robocopy "E:\SIM+\biu-pro\desktop" "E:\open\biunote-desktop" /E `
  /XD node_modules dist-ui target gen .git `
  /XF *.log

# 3) 若开源仓需要自带前端资源，再单独规划复制 web/app、web/alphatab
#    （当前 prepare-ui 依赖上级 biu-pro；开源仓 README 要写清如何配置 API）
```

检查并删掉不应公开的内容：

- 任何 `.env`、密钥、内网 IP 文档
- 仅内部使用的脚本、私有域名说明（可改成「默认连官方 API」）
- `src-tauri/target/`、`node_modules/`、`dist-ui/`（应由构建生成）

根目录建议最终有：

```text
biunote-desktop/
  LICENSE
  README.md
  package.json
  bridge/
  scripts/
  src-tauri/
  .gitignore
```

---

## 5. 初始化 Git 并第一次提交

```powershell
cd E:\open\biunote-desktop

git init -b main
git add .
git status
git commit -m "Initial public release of BiuNote desktop shell"
```

若提示未配置用户名邮箱（只需对本机配置一次）：

```powershell
git config --global user.name "你的名字"
git config --global user.email "你的邮箱@example.com"
```

---

## 6. 同时绑定 GitHub + Gitee 并推送（推荐双 remote）

```powershell
cd E:\open\biunote-desktop

# GitHub
git remote add github https://github.com/你的用户名/biunote-desktop.git

# Gitee
git remote add gitee https://gitee.com/你的用户名/biunote-desktop.git

# 第一次推送
git push -u github main
git push -u gitee main
```

以后改完代码，同步两边：

```powershell
git add .
git commit -m "说明这次改了什么"
git push github main
git push gitee main
```

### 可选：一个命令推两边

```powershell
git remote add all https://github.com/你的用户名/biunote-desktop.git
git remote set-url --add --push all https://github.com/你的用户名/biunote-desktop.git
git remote set-url --add --push all https://gitee.com/你的用户名/biunote-desktop.git

# 之后
git push all main
```

---

## 7. 登录与权限（首次 push 常见坑）

### GitHub

- HTTPS：用 **Personal Access Token** 当密码（Settings → Developer settings → PAT）
- 或配置 SSH 公钥后再用 `git@github.com:...`

### Gitee

- HTTPS：用账号密码，或私人令牌
- 或配置 SSH：Gitee → 设置 → SSH 公钥

测试 SSH：

```powershell
ssh -T git@github.com
ssh -T git@gitee.com
```

---

## 8. 公开 README 建议写什么（引流向）

开源仓 README 建议包含：

1. **一句话**：BiuNote 桌面客户端（开源壳）  
2. **官网 / 下载 / 在线版**链接（引流）  
3. **截图**  
4. **如何构建**（Node / Rust / VS Build Tools）  
5. **默认连接官方 API**（写清：账号、云谱、支付在服务端，不在本仓库）  
6. **开源协议**：MIT  
7. **欢迎 Star / Issue**（GitHub + Gitee 双链）

示例段落：

```markdown
## 相关链接

- 官网 / 在线打谱：https://www.biunow.cn
- GitHub：https://github.com/你的用户名/biunote-desktop
- Gitee：https://gitee.com/你的用户名/biunote-desktop

本仓库仅包含桌面客户端壳。编译、登录、云同步、支付等由官方在线服务提供，服务端源码不开源。
```

---

## 9. 日常维护傻瓜流程

```text
改代码 → git add → git commit → git push github → git push gitee
```

发版本时：

1. 改 `configs/config.yaml` 的 `app.version`（与 WEB / 桌面共用）
2. `git commit -m "本版说明"` → `go run ./cmd/changelog`（把版本号+说明写入 DB，设置里「版本记录」可读）
3. 打 tag：`git tag v0.2.2 && git push github v0.2.2 && git push gitee v0.2.2`
4. 桌面：`cd desktop && npm run build` → 上传 `BiuNote-V0.2.2.exe`
5. GitHub / Gitee Releases 上传同一文件

---

## 10. 检查清单（推之前过一遍）

- [ ] 仓库是 **Public**
- [ ] 根目录有 `LICENSE`（MIT）
- [ ] 没有密钥、`.env`、数据库、后台地址
- [ ] `.gitignore` 已忽略 `node_modules/`、`dist-ui/`、`src-tauri/target/`
- [ ] README 有官网链接（引流）
- [ ] 已 `git push` 到 **GitHub** 和 **Gitee**
- [ ] 本地私有 `biu-pro` 仓仍然是私有，未误公开

---

## 11. 和私有 biu-pro 的关系（别混）

| 仓库 | 可见性 | 内容 |
| --- | --- | --- |
| `biu-pro`（现有） | **私有** | 后端 + 全站 + 桌面开发副本 |
| `biunote-desktop`（新建） | **公开** | 仅桌面开源壳 |

私有仓里继续开发桌面时，可用脚本把变更同步到开源目录再推送；**不要**把私有仓直接改成 Public。
