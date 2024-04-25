# syntax=docker/dockerfile:1.5-labs
FROM rust:1.77.2 as builder

RUN rustup target add x86_64-unknown-linux-musl
RUN --mount=type=cache,target=/var/cache/apt apt-get update && apt-get install -y musl-dev musl-tools

# Run with access to the target cache to speed up builds
WORKDIR /workspace
ADD . .
RUN --mount=type=cache,target=./target \
    --mount=type=cache,target=/usr/local/cargo/registry \
    cargo build --release --target x86_64-unknown-linux-musl

RUN --mount=type=cache,target=./target \
    mv ./target/x86_64-unknown-linux-musl/release/gnostr-chat /usr/local/bin/gnostr-chat

FROM alpine:3
WORKDIR /app
COPY --from=builder /usr/local/bin/gnostr-chat /usr/bin/gnostr-chat
RUN --mount=type=cache,target=/var/cache/apk apk add bind-tools

ENV RUST_BACKTRACE=1

CMD ["gnostr-chat"]
