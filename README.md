# infra-docker-compose

## 📌 프로젝트 개요
이 프로젝트는 Microservice Architecture(MSA) 기반 서비스의 Docker Compose 관리와  
CI/CD 자동 배포를 위한 인프라 레포입니다.  
GitHub Actions + SSH + Docker Compose 를 활용하여 원격 서버에 안전하게 배포됩니다.

---

## 🚀 구성
```
infra-docker-compose/
├── docker-compose.yml         # 전체 MSA 서비스 관리
├── .env                       # 서비스 환경변수
├── scripts/                   # 배포 및 관리 스크립트
│   ├── deploy-infra.sh        # 전체 인프라 배포 스크립트
│   └── deploy-service.sh      # 단일 서비스 배포 스크립트
└── .github/workflows/
    ├── build.yml              # Infra 변경 시 CI/CD 워크플로
    └── service-ci-template.yml # 서비스 공통 CI 템플릿
```

---

## ⚙ 배포 흐름
1️⃣ main 브랜치에 push  
2️⃣ GitHub Actions 실행  
3️⃣ GHCR 이미지 build & push (서비스별)  
4️⃣ SSH → 원격 서버 접속 → docker-compose pull + up 실행

---

## ⚡ 주요 명령
전체 인프라 배포
```bash
  ./scripts/deploy-infra.sh
```

개별 서비스 배포
```bash
  ./scripts/deploy-service.sh <서비스명>
```

Docker Compose 수동 실행
```bash
  docker-compose pull
  docker-compose up -d
```

---

## 🔒 Secrets
GitHub Actions > Secrets 에 등록 필요:
- SERVER_IP → 배포 서버 IP (없으면 none)
- SERVER_USER → SSH 접속 계정
- SERVER_SSH_KEY → SSH Private Key (multi-line)

---

## 📂 서버 디렉토리 권장
- 운영: /opt/infra-docker-compose
- 개발: ~/infra-docker-compose

---

## 💡 주의
✅ docker-compose.yml 변경 시 전체 서비스 영향 → 리뷰 필수  
✅ 서버 경로(cd) 는 실제 서버 구조와 일치시킬 것  
✅ SSH key 권한은 600 유지  
✅ git pull은 repo 내부 Git 트래킹 파일 + 디렉토리 전체를 가져옴 (repo 밖 파일 X)  
✅ git clone은 지정한 최종 디렉토리까지 자동 생성 (상위 디렉토리는 미리 생성 필요)

---

## ✅ TODO
- [ ] Slack/Discord 알림 연동
- [ ] ELK 스택 로그 수집 연계
- [ ] Healthcheck + auto-recover

---

## 📌 라이선스
internal use only
