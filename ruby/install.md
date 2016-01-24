# install ruby on centos 6.x 

### yum repository

```bash
cd /tmp
wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh epel-release-6-8.noarch.rpm
```

### system updated

```bash
yum -y update
yum -y groupinstall "Development Tools"
yum -y install libxslt-devel libyaml-devel libxml2-devel gdbm-devel libffi-devel zlib-devel openssl-devel libyaml-devel readline-devel curl-devel openssl-devel pcre-devel git memcached-devel valgrind-devel mysql-devel ImageMagick-devel ImageMagick
```

### ruby 2.1.0

```bash
version=2.1.0
cd /usr/local/src
wget ftp://ftp.ruby-lang.org/pub/ruby/2.1/ruby-$version.tar.gz 
tar zxvf ruby-$version.tar.gz
cd ruby-$version
./configure
make
make install
```
 
### ruby-gems

```bash
version=2.2.0
cd ..
wget http://production.cf.rubygems.org/rubygems/rubygems-$version.tgz
tar zxvf rubygems-$version.tgz
cd rubygems-$version
/usr/local/bin/ruby setup.rb
```
 
### chef-solo

```bash
gem install bundler chef ruby-shadow --no-ri --no-rdoc
```
