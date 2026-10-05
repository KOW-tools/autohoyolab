FROM rust:alpine AS build

RUN apk add --no-cache build-base

WORKDIR /app

COPY Cargo.toml Cargo.lock ./
COPY src ./src
COPY scripts ./scripts

RUN cargo build --release --bin hoyoverse-api

FROM scratch

COPY --from=build /app/target/release/hoyoverse-api /hoyoverse-api

USER 65534:65534

EXPOSE 8080

ENTRYPOINT ["/hoyoverse-api"]
