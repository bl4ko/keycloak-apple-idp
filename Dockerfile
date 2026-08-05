FROM gradle:8.14-jdk17 AS builder
COPY . /src
WORKDIR /src
RUN gradle test jar --no-daemon && cp build/libs/apple-identity-provider-*.jar /apple-identity-provider.jar

FROM busybox:1.37
COPY --from=builder /apple-identity-provider.jar /apple-identity-provider.jar
