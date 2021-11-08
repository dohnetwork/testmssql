
FROM ubuntu:18.04
LABEL maintainer="dohnetwork@gmail.com"
LABEL description="Ubunta"

#RUN add-apt-repository ppa:ondrej/php && \
#apt-get update
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:ondrej/php
#&&  apt-get update

RUN apt-get -y update &&  DEBIAN_FRONTEND=noninteractive  apt-get install  -y  php7.3 php7.3-dev php7.3-xml -y --allow-unauthenticated nano curl php7.3-comm$
#php7.4-common php7.4-xml php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-dev php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap ph$
#RUN add-apt-repository ppa:ondrej/php -y

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
#RUN curl https://packages.microsoft.com/config/ubuntu/19.10/prod.list > /etc/apt/sources.list.d/mssql-release.list
#RUN exit
#RUN apt-get update &&  DEBIAN_FRONTEND=noninteractive  apt-get install  -y   msodbcsql17
#UN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
#RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN exit
RUN apt-get update
RUN ACCEPT_EULA=Y
#RUN apt-get install msodbcsql17 -y
RUN ACCEPT_EULA=Y apt-get install -y --allow-unauthenticated msodbcsql17 mssql-tools
#sudo ACCEPT_EULA=Y apt-get install mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
#RUN source ~/.bashrc
RUN  apt-get install unixodbc-dev
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.3/mods-available/sqlsrv.ini
RUN printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.3/mods-available/pdo_sqlsrv.ini
RUN exit
RUN  phpenmod -v 7.3 sqlsrv pdo_sqlsrv
WORKDIR /var/www/html/
#COPY a.php b.php d.php  ./
HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -f http://localhost || exit 1
CMD apachectl -D FOREGROUND

