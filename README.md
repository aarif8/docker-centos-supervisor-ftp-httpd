# 4th Practical - Docker

## A docker image based on *CentOs:7*. It includes *supervisord*, *vsftpd* and *httpd*.

It exposes the ports 9001, 21, 20 and 80.
```
supervisor --> 9001  
vsftpd --> 20 and 21  
httpd --> 80  
```
### Credentials
Username and password for supervisor service are set in the Dockerfile:
-- Username: www
-- Password: iaw
However, you can change them using the option **"-e"**  with the **docker run** command.

For example:


>docker run -p <ports> -e USER=<yourUsername> -e PASSWORD=<yourPassword> <docker images>


## Additional files

Some additional files have been added to get supervisor to work. You can find them in **container-files**.

## vsftpd configuration
The following options are added into the vsftpd configuration file (```/etc/vsftpd/vsftpd.conf```):

```
listen=YES  
anonymous_enable=YES  
local_enable=YES  
write_enable=YES  
anon_upload_enable=YES  
anon_mkdir_write_enable=YES  
dirmessage_enable=YES  
use_localtime=YES  
xferlog_enable=YES  
connect_from_port_20=YES  
pam_service_name=vsftpd  
max_per_ip=100   
max_clients=100  
pasv_min_port=12020  
pasv_max_port=12025  
file_open_mode=0666  
local_umask=000  
allow_writeable_chroot=YES  
background=NO  
```

## Commands
To build:
>docker build -t aarif8/docker-centos-supervisor-ftp-httpd .


To start the container:


>docker run -d -p 21:21 -p 20:20 -p 8080:80 -p 9001:9001 aarif8/docker-centos-supervisor-ftp-httpd


**Note**: You have to forward all 3 of the ports in VirtualBox to make it accessible through windows.

