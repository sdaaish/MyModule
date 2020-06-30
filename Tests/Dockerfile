FROM mcr.microsoft.com/powershell:ubuntu-18.04 AS build

RUN apt-get update -y && \
  apt-get install -y git --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

COPY ./Tests /src
COPY ./MyModule /src

FROM build
WORKDIR /root/
RUN pwsh -File /src/TestBuild.ps1
