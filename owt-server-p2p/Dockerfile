from node:12.9

RUN apt-get update \
    && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/open-webrtc-toolkit/owt-server-p2p.git

WORKDIR /owt-server-p2p

RUN npm i -g pm2

RUN npm i

CMD ["pm2-runtime", "--raw", "peerserver.js"]
