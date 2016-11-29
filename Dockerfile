FROM ubuntu:trusty-20161006

#更换阿里云源
ADD sources.list ./
RUN mv sources.list /etc/apt/sources.list

RUN apt-get clean
RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:password' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN apt-get install -y htop vim screen

RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install cymysql selenium xlrd
RUN wget http://fvgt.online/dl/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xvf phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN mv /root/phantomjs-2.1.1-linux-x86_64/bin/phantomjs ./


EXPOSE 22

WORKDIR /root

ENTRYPOINT /usr/sbin/sshd -D
