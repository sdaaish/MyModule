FROM microsoft/powershell AS build

RUN apt-get update -y && \
  apt-get install -y git --no-install-recommends

COPY ./Tests /src
COPY ./MyModule /src

FROM build
WORKDIR /root/
RUN pwsh -File /src/TestBuild.ps1
