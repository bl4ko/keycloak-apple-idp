FROM gradle:8.14-jdk17@sha256:048f6802c5767837f5138d19d151cf0ec7952ba9a3d2a7c8d886d448f313dffb AS builder
COPY . /src
WORKDIR /src
RUN gradle test jar --no-daemon && cp build/libs/apple-identity-provider-*.jar /apple-identity-provider.jar

FROM busybox:1.38@sha256:dc2d74b28e4cf8984fa52af1f39bc7c3d9c73760b41a74d629f5d11b1ab28616
COPY --from=builder /apple-identity-provider.jar /apple-identity-provider.jar
