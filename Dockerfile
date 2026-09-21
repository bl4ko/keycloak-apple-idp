FROM gradle:9.7-jdk17@sha256:b0405bbcff65a32f4acc253cf6ba9c70b5c1553c80128fe6051cc6945e0e5529 AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew jar --no-daemon && cp build/libs/apple-identity-provider-*.jar /apple-identity-provider.jar

FROM busybox:1.38@sha256:dc2d74b28e4cf8984fa52af1f39bc7c3d9c73760b41a74d629f5d11b1ab28616
COPY --from=builder /apple-identity-provider.jar /apple-identity-provider.jar
