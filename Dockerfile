FROM gradle:9.8-jdk17@sha256:1f5de3a1aae5aeb06d267b9ab5645bfd6fdb6a405a51a2e6af591eb8066de405 AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew jar --no-daemon && cp build/libs/apple-identity-provider-*.jar /apple-identity-provider.jar

FROM busybox:1.38@sha256:fd7dc98638c8e305f4dc34e979f1c0fdfdcaeb0fbf8fcff77ae834b6da3d7e6e
COPY --from=builder /apple-identity-provider.jar /apple-identity-provider.jar
