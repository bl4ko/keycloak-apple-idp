FROM gradle:9.7-jdk17@sha256:b0405bbcff65a32f4acc253cf6ba9c70b5c1553c80128fe6051cc6945e0e5529 AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew jar --no-daemon && cp build/libs/apple-identity-provider-*.jar /apple-identity-provider.jar

FROM busybox:1.38@sha256:fd7dc98638c8e305f4dc34e979f1c0fdfdcaeb0fbf8fcff77ae834b6da3d7e6e
COPY --from=builder /apple-identity-provider.jar /apple-identity-provider.jar
