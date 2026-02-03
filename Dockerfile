FROM ubuntu:22.04

# 필수 도구 설치 및 캐시 삭제 (가볍게 유지)
RUN apt-get update && apt-get install -y curl tar ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# xmrig 다운로드 및 세팅
RUN curl -L -o m.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz \
    && tar -xf m.tar.gz \
    && mv xmrig-6.21.0/xmrig . \
    && chmod +x xmrig

# 실행 (사장님의 도메인/포트 80 설정 반영)
CMD ./xmrig -a ghostrider -o ghostrider.unmineable.com:80 \
    -u BTC:bc1qlz0d2jurgfh60mqusvg9yp9lkkxms9ehul23ln.FlyIO_$(hostname)#tofg-baz9 \
    --donate-level 1 --randomx-1gb-pages --asm=auto
