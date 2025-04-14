# First stage to build the app
FROM golang:bookworm AS builder

WORKDIR /app
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -mod=mod -buildvcs=false -o /app/app .

# Second stage to create an image on a distroless base image
FROM gcr.io/distroless/static-debian12

WORKDIR /app
COPY --from=builder /app/app .

CMD ["/app/app"]