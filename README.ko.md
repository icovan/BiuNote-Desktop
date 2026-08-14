# BiuNote Desktop

[English](README.md) | [简体中文](README.zh-CN.md) | [日本語](README.ja.md) | **한국어**

**가장 단순한 문법. 가장 멋진 악보.**

BiuNote 코드 / 명령으로 몇 분이면 재생·수정 가능한 기타 반주 악보를 만듭니다.

[웹사이트 / 온라인 편집](https://www.biunow.cn) · [다운로드](https://www.biunow.cn) · [GitHub](https://github.com/icovan/BiuNote-Desktop) · [Gitee](https://gitee.com/zaokework/biunote-desktop)

<!-- Uncomment after adding docs/screenshots/01-hero-workspace.png -->
<!-- ![Workbench](docs/screenshots/01-hero-workspace.png) -->

---

## 이 저장소는

BiuNote 작업대를 감싼 **데스크톱 클라이언트(Tauri, MIT)** 이며, 공식 API `https://www.biunow.cn` 에 연결합니다.

| 포함 | 미포함 |
| --- | --- |
| 데스크톱 셸, 빌드 스크립트, 아이콘 | 서버, 결제, 관리자, 전체 제품 소스 |

로그인, 클라우드 악보, 컴파일, Pro 기능은 공식 온라인 서비스에서 제공됩니다. 자체 호스팅·상업 이용은 아래 라이선스를 보세요.

---

## 왜 BiuNote인가

Guitar Pro 같은 정밀 조판이 목표가 아닙니다. **아이디어 → 재생 가능한 악보를, 분 단위로.**

- **코드로 기보** — 줄은 `a`–`f`, 마디는 `|`, 코드와 기법은 짧은 토큰
- **명령으로 악보** — 구성 × 코드 × 리듬 패턴 → 이후에도 고칠 수 있는 악보
- **보기** — 타브 / 숫자보 / 오선 / 싱어송라이터 혼합
- **가져갈 수 있음** — 재생. Pro는 PDF / Guitar Pro / MIDI 내보내기

```text
title: Demo
tempo: 96
[V:1]
"Am" a0 c2 e0 a0 | "G"  V[axfx] |
```

막히면 앱의 **문법**과 매뉴얼을 여세요.

---

## 소스에서 실행

Node.js 18+, Rust, Windows에서는 VS2022(C++ 데스크톱 / MSVC), WebView2가 필요합니다.

```powershell
npm install
npm run dev
```

기본은 운영 API입니다. 로컬 백엔드:

```powershell
$env:BIUPRO_DESKTOP_LOCAL = "1"   # → http://127.0.0.1:8091
npm run dev
```

포터블 빌드:

```powershell
npm run build
```

결과물: `src-tauri/target/release/` (`BiuNote.exe` 및 버전 파일).

---

## Pro와 소스 라이선스

데스크톱 셸은 **MIT, 무료**입니다. 계정, 클라우드 동기화, 결제, **전체 서버**는 이 저장소에 없습니다.

- **온라인 편집 / Pro** — 월간 · 연간 · 평생 → [요금](https://www.biunow.cn)
- **풀스택 소스 라이선스** (서버 포함, 자체 호스팅):

| 등급 | 대상 | 참고가 |
| --- | --- | --- |
| 개인 | 본인 배포. 재판매·공개 SaaS 불가 | ¥2,999 |
| 팀 | 팀 내부 + 도입 지원 1회 | ¥6,999 |
| 상업 | 브랜드 교체·상업 런칭(비독점) | ¥19,999 |

범위와 가격은 상담 후 확정합니다. [웹사이트](https://www.biunow.cn)로 문의하세요.

> 대가를 받는 것은 전체 제품 소스와 라이선스이며, 이 MIT 데스크톱 저장소가 아닙니다.

---

## License

MIT
