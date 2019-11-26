# Change software sources
sed /etc/apt/sources.list -e 's/security.ubuntu.com/mirrors.aliyun.com/g' -i \
&& sed /etc/apt/sources.list -e 's/archive.ubuntu.com/mirrors.aliyun.com/g' -i
