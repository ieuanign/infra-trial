FROM golang:1.26-alpine AS build
WORKDIR /src
COPY go.mod ./
COPY *.go ./
RUN CGO_ENABLED=0 go build -o /greeter .

FROM gcr.io/distroless/static-debian12
COPY --from=build /greeter /greeter
EXPOSE 8080
USER nonroot
ENTRYPOINT ["/greeter"]
