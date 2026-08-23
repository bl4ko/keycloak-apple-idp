FROM gradle:9.6-jdk17@sha256:aba72d36b08b131dfb7bd420802a629d137b98840e039d25eb0bfaff7206e4a9 AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew jar --no-daemon && cp build/libs/apple-identity-provider-*.jar /apple-identity-provider.jar

FROM busybox:1.38@sha256:dc2d74b28e4cf8984fa52af1f39bc7c3d9c73760b41a74d629f5d11b1ab28616
COPY --from=builder /apple-identity-provider.jar /apple-identity-provider.jar
