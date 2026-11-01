FROM gradle:9.8-jdk17@sha256:1f5de3a1aae5aeb06d267b9ab5645bfd6fdb6a405a51a2e6af591eb8066de405 AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew jar --no-daemon && cp build/libs/apple-identity-provider-*.jar /apple-identity-provider.jar

FROM busybox:1.38@sha256:a46257e06c82ad85242d0d38077d0a52d9896389ca60a1a59d3463db586e5fa4
COPY --from=builder /apple-identity-provider.jar /apple-identity-provider.jar
