FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV MEDIA_SDK_VER=18.4.0

# Update the system
RUN apt-get update

# Install utils
RUN apt-get install -y ca-certificates git lsb-release mongodb nodejs npm sudo wget

RUN npm install -g grunt-cli node-gyp

# Keep proxy environment for sudo
RUN bash -c "echo \"Defaults env_keep = \\\"http_proxy https_proxy no_proxy \\\"\" >> /etc/sudoers"

RUN wget https://github.com/Intel-Media-SDK/MediaSDK/releases/download/intel-mediasdk-$MEDIA_SDK_VER/MediaStack.tar.gz -P /tmp
RUN cd /tmp && tar -zxf MediaStack.tar.gz && cd MediaStack && ./install_media.sh
RUN rm /tmp/MediaStack.tar.gz && rm -rf /tmp/MediaStack
ENV MFX_HOME=/opt/intel/mediasdk

RUN git clone https://github.com/open-webrtc-toolkit/owt-server.git
WORKDIR /owt-server

# This is needed to patch licode
RUN  git config --global user.email "you@example.com" && \
  git config --global user.name "Your Name"

RUN ./scripts/installDepsUnattended.sh
RUN ./scripts/build.js -t all --check
RUN ./scripts/pack.js -t all --install-module
RUN ./dist/video_agent/install_openh264.sh
RUN cd /owt-server/dist/bin/ \
    && sed -i '/daemon.sh .* app/d' ./stop-all.sh \
    && sed -i '/daemon.sh .* app/d' ./start-all.sh \
    && sed -i '/daemon.sh .* app/d' ./restart-all.sh

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.5.1/wait /wait
RUN chmod +x /wait

ADD ./config /config
ADD ./start.sh /start.sh
