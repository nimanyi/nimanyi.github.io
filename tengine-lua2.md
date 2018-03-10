	groupadd apache
	useradd -g apache apache
	
	mkdir -p /var/lib/nginx/client/
	mkdir -p /data/proxy/proxy_temp_dir


    yum -y install zip unzip wget
	
	wget -c http://luajit.org/download/LuaJIT-2.0.5.tar.gz
	
	tar zxvf LuaJIT-2.0.5.tar.gz
	
	cd LuaJIT-2.0.5
	
	make && make install
	
	export LUAJIT_LIB=/usr/local/lib
	export LUAJIT_INC=/usr/local/include/luajit-2.0
		
	cd /opt/src
	
	wget -c https://github.com/simpl/ngx_devel_kit/archive/v0.3.1rc1.tar.gz
	
	wget -c https://github.com/openresty/lua-nginx-module/archive/v0.10.12rc2.tar.gz
	
	tar zxvf v0.3.1rc1.tar.gz
	
	tar zxvf v0.10.12rc2.tar.gz
	
	chmod +x /opt/src/zlib-1.2.8/configure
	
	rpm -ivh   http://ftp.linux.ncsu.edu/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

    yum -y install GeoIP GeoIP-data GeoIP-devel
		
	cd /opt/src/tengine-2.1.0
	
	./configure \
	  --prefix=/opt/webserver/nginx \
	  --conf-path=/opt/webserver/nginx/etc/nginx.conf \
	  --error-log-path=/var/log/nginx/error.log \
	  --pid-path=/var/run/nginx/nginx.pid  \
	  --lock-path=/var/lock/nginx.lock \
	  --user=apache \
	  --group=apache \
	  --with-http_ssl_module \
	  --with-http_flv_module \
	  --with-http_stub_status_module \
	  --with-http_gzip_static_module \
	  --with-http_realip_module \
	  --with-http_concat_module \
	  --with-http_geoip_module \
	  --http-log-path=/var/log/nginx/access.log \
	  --http-client-body-temp-path=/var/lib/nginx/client/ \
	  --http-proxy-temp-path=/var/lib/nginx/proxy/ \
	  --http-fastcgi-temp-path=/var/lib/nginx/fcgi/  \
	  --http-uwsgi-temp-path=/var/lib/nginx/uwsgi/  \
	  --http-scgi-temp-path=/var/lib/nginx/scgi/  \
	  --with-syslog  \
	  --with-openssl=/opt/src/openssl-1.0.2c \
	  --with-zlib=/opt/src/zlib-1.2.8 \
	  --add-module=/opt/src/gnosek-nginx-upstream-fair-a18b409 \
	  --add-module=/opt/src/ngx_cache_purge-2.3 \
	  --add-module=/opt/src/lua-nginx-module-0.10.12rc2 \
	  --add-module=/opt/src/ngx_devel_kit-0.3.1rc1 \
	  --with-pcre=/opt/src/pcre-8.37
	make -j2

    make install
	
	ln -s /usr/local/lib/libluajit-5.1.so.2 /lib64/libluajit-5.1.so.2
