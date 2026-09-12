FROM gradle:9.7-jdk17@sha256:853c26f1712d8c97e8d312d3a628e237c53a6c6beecd1fab6f8fc808a741ce8b AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew jar --no-daemon && cp build/libs/apple-identity-provider-*.jar /apple-identity-provider.jar

FROM busybox:1.38@sha256:dc2d74b28e4cf8984fa52af1f39bc7c3d9c73760b41a74d629f5d11b1ab28616
COPY --from=builder /apple-identity-provider.jar /apple-identity-provider.jar
