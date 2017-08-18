# NodeJs web application env
# VERSION       1.0

# use the ubuntu base centos image & nodejs dockerfile provided by https://hub.docker.com/.
FROM centos:latest

MAINTAINER JasonTao niuhaitao5@jd.com

# creare node user, grant exec dir.
RUN useradd node -s /sbin/nologin -M
# creare nginx user grant exec dir.
RUN useradd nginx -s /sbin/nologin -M
  
# set node exec env.
ENV NPM_CONFIG_LOGLEVEL info
ENV export PATH=/usr/local/share/npm/bin:$PATH

# 修改163源
ADD http://mirrors.163.com/.help/CentOS7-Base-163.repo /etc/yum.repos.d/
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
	&& mv /etc/yum.repos.d/CentOS7-Base-163.repo /etc/yum.repos.d/CentOS-Base.repo
# 安装
RUN yum clean all \
	&& yum makecache \
	&& yum -y install wget curl
#install nginx dep
RUN yum -y install gcc gcc-c++ autoconf automake \
	&& yum -y install zlib zlib-devel openssl openssl-devel pcre-devel

# 安装nodejs
ADD https://nodejs.org/dist/v8.4.0/node-v8.4.0-linux-x64.tar.gz /opt/
RUN cd /opt \
	&& mv node-v8.4.0-linux-x64 node \
	&& chgrp -R node node \
	&& chown -R node node \
    && echo "export PATH=/opt/node/bin:$PATH" >> /etc/profile \
	&& source /etc/profile

# 安装nginx # && chmod +755 /etc/init.d/nginx \
# wget -P /etc/init.d/ https://raw.githubusercontent.com/ppgs8903/DockerDoc/master/node/nginx --no-check-certificate \
ADD http://nginx.org/download/nginx-1.13.4.tar.gz /opt/
ADD https://raw.githubusercontent.com/ppgs8903/DockerDoc/master/node/nginx /etc/init.d/
RUN cd /opt \
	&& mv nginx-1.13.4 nginx \
	&& chgrp -R nginx nginx \
	&& chown -R nginx nginx \
    && cd nginx \
	&& ./configure --user=nginx --group=nginx --with-http_ssl_module --with-http_stub_status_module \
	&& make \
	&& make install

#RUN /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf