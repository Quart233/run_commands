# Change software sources
sed /etc/apt/sources.list -e 's/security.ubuntu.com/mirrors.aliyun.com/g' -i \
&& sed /etc/apt/sources.list -e 's/archive.ubuntu.com/mirrors.aliyun.com/g' -i


# Update software sources & install apache php7.2
apt-get update \
&& apt-get install -y apache2 php7.2

