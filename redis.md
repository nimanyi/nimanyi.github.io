	./redis-trib.rb add-node 192.168.0.175:6390 192.168.0.175:6391 192.168.0.175:6392
	./redis-trib.rb create --replicas 1 192.168.0.175:6390 192.168.0.175:6391 192.168.0.175:6392 192.168.0.108:6390 192.168.0.108:6391 192.168.0.108:6392


	./redis-trib.rb create --replicas 1 192.168.0.231:6390 192.168.0.231:6391 192.168.0.231:6392 192.168.0.232:6390 192.168.0.232:6391 192.168.0.232:6392

nginx 

purge CACHE

	http://blog.csdn.net/qshpeng/article/details/50930332


----------

	yum -y install gcc automake autoconf libtool make
	yum -y install zlib-devel curl-devel openssl-devel  apr-devel apr-util-devel


	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	curl -sSL https://get.rvm.io | bash -s stable
	rvm list known
	gem install redis




	wget -c http://download.redis.io/releases/redis-4.0.6.tar.gz

	make MALLOC=libc  
	make install PREFIX=/usr/local/redis

	yum -y install keepalived


	find / –type f |xargs grep "uu898.cc"
	find .|xargs grep -ri "ddzservice"
	grep -r "httpd" /opt/




python 安装redis支持


	yum -y install python-pip
	pip install redis

nginx redis Lua 支持

	wget -c https://github.com/openresty/lua-resty-redis/archive/v0.26.zip

	unzip v0.26.zip

	