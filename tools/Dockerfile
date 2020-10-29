FROM centos:7.8.2003

MAINTAINER XiaoRu Hua <huahuaxr@msn.com>

WORKDIR /opt

RUN yum install -y wget \
    && yum clean all \
    && cd /etc/yum.repos.d/ \
    && mkdir repo \
    && mv *.repo repo \
    && cd /etc/yum.repos.d/ \
    && curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
    && curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo \
    && yum -y makecache \
    && yum install -y epel-release

COPY resources/* /opt/

# tools
RUN yum install -y --nogpgcheck net-tools nc openssh perl autoconf unzip git wget bind-utils jq vim-enhanced \
    && yum install -y --nogpgcheck which bc supervisor \
    && yum install -y --nogpgcheck expect

# java
RUN yum install -y --nogpgcheck java-1.8.0-openjdk-devel

# python
RUN rpm -ivh /opt/rl*.rpm \
    && rm -rf /opt/*.rpm \
    && yum clean all \
    && rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/* \
    && tar -xzf /opt/pip.tar.gz -C ~ \
    && yum install -y --nogpgcheck gcc \
    && yum install -y --nogpgcheck gcc-c++ \
    && yum install -y --nogpgcheck python36-devel \
    && curl --silent --show-error https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py \
    && python3 /tmp/get-pip.py \
    && rm -f /opt/*zip \
    && rm -f /opt/*gz \
    && yum clean all \
    && rm -rf /tmp/* /var/lib/apt/* /var/cache/* /var/log/* \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && sed -i '1s/python.*$/python2.7/' /usr/bin/yum \
    && sed -i '1s/python.*$/python2.7/' /usr/libexec/urlgrabber-ext-down \
    && sed -i '1s/python.*\s/python2.7/' /usr/bin/yum-config-manager

# ansible
RUN yum install --nogpgcheck -y ansible \
    && sed -i "s@\#host_key_checking = False@host_key_checking = False@g" /etc/ansible/ansible.cfg \
    && sed -i "s@\#log_path = \/var\/log\/ansible.log@log_path = \/var\/log\/ansible.log@g" /etc/ansible/ansible.cfg \
    && cd /etc/ansible \
    && mkdir -p callback_plugins \
    && cd callback_plugins \
	&& /bin/cp /opt/profile_tasks.py . \
	&& sed -i "s@\#callback_whitelist.*@&\ncallback_whitelist = profile_tasks@g" /etc/ansible/ansible.cfg \
	&& rm -f /opt/profile_tasks.py /opt/*~ /opt/*.swp

ENTRYPOINT ["/bin/bash"]
