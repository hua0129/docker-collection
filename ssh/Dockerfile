FROM centos:centos7.8.2003

MAINTAINER centos-ssh-systemctl

#安装ssh和其他服务软件包
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
    && curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo \
    && yum -y makecache \
	&& yum install -y epel-release openssh-clients openssh-server net-tools \
    && yum -y clean all

RUN echo "123456" | passwd --stdin root
    && sed -i 's/^#\s*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key

RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh

#CMD ["/usr/sbin/sshd","-D"]

RUN echo "#!/bin/bash" > /entrypoint.sh \
    && echo "/usr/sbin/init" >> /entrypoint.sh \
    && echo "exec /usr/sbin/sshd -D " >> /entrypoint.sh \
    && echo "exec \"$@\"" >> /entrypoint.sh \
    && chmod 777 /entrypoint.sh \
	&& cat /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

#暴露端口
EXPOSE 22
