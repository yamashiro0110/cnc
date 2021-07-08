FROM openjdk:11 AS Java

ARG digdagServerScript=bin/digdag-server-run.sh

COPY conf/server.properties /usr/local/etc/
COPY ${digdagServerScript} /usr/local/bin/digdag-server.sh

# install digdag
RUN curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
 && chmod +x /usr/local/bin/digdag \
 && chmod +x /usr/local/bin/digdag-server.sh

ENTRYPOINT [ "/usr/local/bin/digdag-server.sh" ]
