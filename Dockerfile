FROM gradle:9.8-jdk17@sha256:e5c0087b1bfc5da783fb514f78a7944d605bfbcd789fa644d0cd1c111d40572c AS builder
COPY . /src
WORKDIR /src
RUN ./gradlew jar --no-daemon && cp build/libs/apple-identity-provider-*.jar /apple-identity-provider.jar

FROM busybox:1.38@sha256:fd7dc98638c8e305f4dc34e979f1c0fdfdcaeb0fbf8fcff77ae834b6da3d7e6e
COPY --from=builder /apple-identity-provider.jar /apple-identity-provider.jar
