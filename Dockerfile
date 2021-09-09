FROM node:12-alpine as builder
WORKDIR /yapi
RUN apk add --no-cache wget python make
ENV VERSION=1.9.3
RUN wget https://github.com/YMFE/yapi/archive/refs/tages/v${VERSION}.zip
RUN unzip v${VERSION}.zip && mv yapi-${VERSION} vendors
RUN cd /yapi/vendors && cp config_example.json ../config.json && npm install --production --registry https://registry.npm.taobao.org

FROM node:12-alpine
MAINTAINER Yapi接口
ENV TZ="Asia/Shanghai"
WORKDIR /yapi/vendors
COPY --from=builder /yapi/vendors /yapi/vendors
COPY ./config.json /yapi
EXPOSE 3000
ENTRYPOINT ["node"]