# 표준 리눅스 이미지로 호환성 확보 (Fly.io 빌더의 플랫폼 불일치 방지)
FROM --platform=linux/amd64 ubuntu:22.04

# 필수 도구 설치
RUN apt-get update && apt-get install -y curl tar ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# xmrig 설치 (사장님 명령어 기반)
RUN curl -L -o m.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz \
    && tar -xf m.tar.gz \
    && mv xmrig-6.21.0/xmrig . \
    && chmod +x xmrig

# 실행 명령어 (CPU 1개, 램 4GB 여유 보존 세팅)
CMD ./xmrig -a ghostrider -o ghostrider.unmineable.com:80 \
    -u BTC:bc1qlz0d2jurgfh60mqusvg9yp9lkkxms9ehul23ln.FlyIO_$(hostname)#tofg-baz9 \
    --donate-level 1 --randomx-1gb-pages --asm=auto --threads 15 --cpu-max-threads-hint 90
