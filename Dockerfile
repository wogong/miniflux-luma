FROM golang:1.19-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o /app/miniflux-luma miniflux-luma.go

FROM alpine
COPY --from=builder /app/miniflux-luma /miniflux-luma
RUN touch /api_token
EXPOSE 8080
ENTRYPOINT ["/miniflux-luma"]
