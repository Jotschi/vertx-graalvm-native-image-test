FROM debian:stable-slim AS build-env

FROM gcr.io/distroless/base
ADD app app
COPY --from=build-env /lib/x86_64-linux-gnu/libz.so.1 /lib/x86_64-linux-gnu/libz.so.1
CMD ["/app"]

