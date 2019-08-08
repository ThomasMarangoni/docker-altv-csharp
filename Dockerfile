FROM debian:10
LABEL maintainer="DasChaos <Twitter: @DasChaosAT>"

ENV PORT 7788
ENV UID 0

RUN apt-get update && \
    apt-get install -y wget libc-bin apt-transport-https gpg

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
    mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \
    wget -q https://packages.microsoft.com/config/debian/9/prod.list && \
    mv prod.list /etc/apt/sources.list.d/microsoft-prod.list

RUN apt-get update && \
    apt-get install -y aspnetcore-runtime-2.2

RUN wget --no-cache -O altv-server https://cdn.altv.mp/server/stable/x64_linux/altv-server && \
    wget --no-cache -O libnode.so.64  https://cdn.altv.mp/alt-node/libnode.so.64 && \
    wget --no-cache -O vehmodels.bin https://cdn.altv.mp/server/stable/x64_linux/data/vehmodels.bin&& \
    wget --no-cache -O vehmods.bin https://cdn.altv.mp/server/stable/x64_linux/data/vehmods.bin && \
    wget --no-cache -O libnode-module.so https://cdn.altv.mp/node-module/stable/x64_linux/libnode-module.so && \
    wget --no-cache -O libcsharp-module.so https://cdn.altv.mp/coreclr-module/stable/x64_linux/libcsharp-module.so && \
    mkdir /altv && \
    mkdir /altv/data && \
    mkdir /altv/modules && \
    mkdir /altv/resources-data && \
    mv altv-server /altv/ && \
    mv libnode.so.64 /altv/ && \
    mv vehmodels.bin /altv/data && \
    mv vehmods.bin /altv/data && \
    mv libnode-module.so /altv/modules && \
    mv libcsharp-module.so /altv/modules

RUN apt-get purge -y wget && \
    apt-get clean

RUN mkdir /altv-persistend && \
    mkdir /altv-persistend/config && \
    mkdir /altv-persistend/resources && \
    mkdir /altv-persistend/resources-data && \
    mkdir /altv-persistend/logs && \
    ln -s /altv-persistend/config /altv/config && \
    ln -s /altv-persistend/resources /altv/resources && \
    ln -s /altv-persistend/resources-data /altv/resources-data && \
    ln -s /altv-persistend/logs /altv/logs

EXPOSE ${PORT}/tcp
EXPOSE ${PORT}/udp

VOLUME /altv-persistend/

ADD start_server.sh /altv/start_server.sh
RUN chmod +x /altv/start_server.sh
RUN chmod +x /altv/altv-server

USER ${UID}

ENTRYPOINT ["/altv/start_server.sh"]
CMD ["sh"]

