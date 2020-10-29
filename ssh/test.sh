docker run -d --privileged --name test-ssh-systemctl -h test-ssh-systemctl \
   --net hadoop_net --ip 172.10.0.5 -p 10028:22 hua0129/centos-ssh-systemctl

