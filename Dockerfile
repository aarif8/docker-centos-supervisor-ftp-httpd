FROM 		centos:7
MAINTAINER 	aarif@ilg.cat

RUN		yum update -y && \
		yum install -y epel-release && \
		yum install -y iproute python-setuptools hostname inotify-tools yum-utils which jq && \
		yum clean all && \
		easy_install supervisor


RUN		yum update -y && \ 
		yum install -y vsftpd wget tar bzip2 unzip

RUN		{ echo 'listen=YES'; \
		echo 'anonymous_enable=YES'; \
		echo 'local_enable=YES'; \
		echo 'write_enable=YES'; \
		echo 'anon_upload_enable=YES'; \
		echo 'anon_mkdir_write_enable=YES'; \
		echo 'dirmessage_enable=YES'; \
		echo 'use_localtime=YES'; \
		echo 'xferlog_enable=YES'; \
		echo 'connect_from_port_20=YES'; \
		echo 'pam_service_name=vsftpd'; \
		echo 'max_per_ip=100 '; \
		echo 'max_clients=100'; \
		echo 'pasv_min_port=12020'; \
		echo 'pasv_max_port=12025'; \
		echo 'file_open_mode=0666'; \
		echo 'local_umask=000'; \
		echo 'allow_writeable_chroot=YES'; \
		echo 'background=NO'; \
		} > /etc/vsftpd/vsftpd.conf


RUN		yum install -y sudo vim httpd

RUN 		echo 'alias ls="ls --color"' >> ~/.bashrc \
		&& echo 'alias ll="ls -lh"' >> ~/.bashrc \
		&& echo 'alias la="ls -lha"' >> ~/.bashrc

RUN		yum clean all && rm -rf /tmp/yum*

ENV		USER=www
ENV		PASSWORD=iaw


ADD		container-files /

RUN		sed -ri "s/www/${USER}/g" /etc/supervisord.conf && \
		sed -ri "s/iaw/${PASSWORD}/g" /etc/supervisord.conf


VOLUME		["/data"]

EXPOSE		9001 20 21 80


ENTRYPOINT	["/config/bootstrap.sh"]
