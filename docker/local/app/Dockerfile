FROM perl:latest

RUN mkdir /myapp
VOLUME /myapp

RUN cpanm Carton Module::Setup LWP::Protocol::https
RUN cpanm https://codeload.github.com/Konboi/p5-Module-Setup-Flavor-ArkDBIC/tar.gz/master
RUN useradd -m myuser

RUN apt-get update && apt-get install -y vim tree mysql-client sudo
RUN echo "myuser ALL=NOPASSWD: ALL" >> /etc/sudoers \
&& echo "Defaults:app !requiretty" >> /etc/sudoers

WORKDIR /myapp
USER myuser


RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
COPY vimrc /home/myuser/.vimrc

ENTRYPOINT [ "carton", "exec" ]

#CMD [ "carton", "-t", "perl-dev" ]
#CMD [ "carton", "exec" ]
