FROM perl:latest

RUN mkdir /myapp
VOLUME /myapp

RUN cpanm Carton Module::Setup LWP::Protocol::https
RUN cpanm https://codeload.github.com/Konboi/p5-Module-Setup-Flavor-ArkDBIC/tar.gz/master
RUN useradd -m myuser

WORKDIR /myapp
USER myuser

ENTRYPOINT [ "carton", "exec" ]
