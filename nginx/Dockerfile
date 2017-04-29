FROM alpine:latest

RUN apk --no-cache add \
      nginx

COPY ./etc /etc

ENTRYPOINT ["nginx"]
