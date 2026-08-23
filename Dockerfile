FROM gradle:8.14-jdk17@sha256:8b461ed32051cf0758d44ecec45e5e435a86b1d899c86ddb5ef436de110506a6 AS builder
COPY . /src
WORKDIR /src
RUN gradle test jar --no-daemon && cp build/libs/apple-identity-provider-*.jar /apple-identity-provider.jar

FROM busybox:1.38@sha256:dc2d74b28e4cf8984fa52af1f39bc7c3d9c73760b41a74d629f5d11b1ab28616
COPY --from=builder /apple-identity-provider.jar /apple-identity-provider.jar
