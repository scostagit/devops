FROM golang:1.18.10 as build
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:3.18.4 as pp
WORKDIR /app
# we can add many files from other build images like this:
# *** relaase that we are not building the image below ***
# COPY --from=fabricioverenoz/pacote-bin:v1 /pkg/pacote.bin .
COPY --from=build /build/main .
CMD ["./main"]