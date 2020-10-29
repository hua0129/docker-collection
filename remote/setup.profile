this_dir=$(cd `dirname $0`; pwd)
ansible_cdh=$( base_dir=${this_dir/\/remote*/} && basename $base_dir )

# 外网安装机的IP地址, 请修改这个参数
IPS[0]=192.168.0.50
IPS[0]=47.114.119.172

user=root

echo directory: $ansible_cdh

# 后面不用修改
echo ====================================================================================================================
#MODE=pem
MODE=passwd

export IPS MODE user ansible_cdh

echo ssh -i pem/ssh-key.pem $user@${IPS[0]}
echo ssh $user@${IPS[0]}

echo ====================================================================================================================


