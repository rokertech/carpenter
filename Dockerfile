# Build stage
FROM golang:1.17.13-alpine AS build
WORKDIR /src
COPY . /src
RUN go build

FROM hashicorp/packer:1.11.2 AS packer

# Final stage
FROM alpine

COPY --from=build /src/carpenter /usr/local/bin/carpenter
RUN carpenter help

COPY --from=packer /bin/packer /usr/local/bin/packer
RUN packer version