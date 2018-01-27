

**安装luajit2.0稳定版**

	wget -c http://luajit.org/download/LuaJIT-2.0.5.tar.gz

	tar zxvf LuaJIT-2.0.5.tar.gz

----------
	export LUAJIT_LIB=/usr/local/lib
	export LUAJIT_INC=/usr/local/include/luajit-2.0

	wget -c https://github.com/simpl/ngx_devel_kit/archive/v0.3.1rc1.tar.gz

	wget -c https://github.com/openresty/lua-nginx-module/archive/v0.10.12rc2.tar.gz

	cd  /opt/src/pcre-8.37
	chmod +x config
	make && make install


----------

**tengine编译的配置文件**


	./configure \
	  --prefix=/opt/webserver/nginx \
	  --conf-path=/opt/webserver/nginx/etc/nginx.conf \
	  --error-log-path=/var/log/nginx/error.log \
	  --pid-path=/var/run/nginx/nginx.pid  \
	  --lock-path=/var/lock/nginx.lock \
	  --user=www \
	  --group=www \
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
	  --with-pcre=/opt/src/pcre-8.37 \
	  --with-openssl=/opt/src/openssl-1.0.2c \
	  --with-zlib=/opt/src/zlib-1.2.8 \
	  --add-module=/opt/src/gnosek-nginx-upstream-fair-a18b409 \
	  --add-module=/opt/src/ngx_cache_purge-2.3 \
	  --add-module=/opt/src/ngx_devel_kit-0.3.1rc1 \
	  --add-module=/opt/src/lua-nginx-module-0.10.12rc2 \
	
	

----------
    
**lua的软连接**

	ln -s /usr/local/lib/libluajit-5.1.so.2 /lib64/libluajit-5.1.so.2


----------

**nginx 启动脚本内容**


	#! /bin/bash
	#
	# nginx          Start/Stop the nginx daemon.
	#
	# chkconfig: 2345 90 60
	# description: nginx
	# processname: nginx
	# config: /opt/webserver/nginx/etc/nginx.conf
	# pidfile: /var/run/nginx/nginx.pid

	# Source function library.
	. /etc/init.d/functions

	# Progran name
	prog="nginx"

	start() {
  	      echo -n $"Starting $prog: "
       	 if [ -e /var/lock/nginx.lock ]; then
       	     if [ -e /var/run/nginx/nginx.pid ] && [ -e /proc/`cat /var/run/nginx/nginx.pid ` ]; then
                echo -n $"cannot start $prog: nginx is already running."
                failure $"cannot start $prog: nginx is already running."
                echo
                return 1
            fi
        fi
        /opt/webserver/nginx/sbin/nginx
        RETVAL=$?
        [ $RETVAL -eq 0 ] && success $"$prog start" || failure $"$prog start"
        [ $RETVAL -eq 0 ] && touch /var/lock/nginx.lock
        echo
        return $RETVAL
	}

	stop() {
        echo -n $"Stopping $prog: "
        if [ ! -e /var/lock/nginx.lock ] || [ ! -e /var/run/nginx/nginx.pid  ]; then
            echo -n $"cannot stop $prog: nginx is not running."
            failure $"cannot stop $prog: nginx is not running."
            echo
            return 1
        fi
        PID=`cat /var/run/nginx/nginx.pid `
        if checkpid $PID 2>&1; then
            # TERM first, then KILL if not dead
            kill -TERM $PID >/dev/null 2>&1
            usleep 100000
            if checkpid $PID && sleep 1 && checkpid $PID && sleep 3 && checkpid $PID; then
                kill -KILL $PID >/dev/null 2>&1
                usleep 100000
            fi
        fi
        checkpid $PID
        RETVAL=$((! $?))
        [ $RETVAL -eq 0 ] && success $"$prog shutdown" || failure $"$prog shutdown"
        [ $RETVAL -eq 0 ] && rm -f /var/lock/nginx.lock;
        echo
        return $RETVAL
	}

	status() {
        status $prog
        RETVAL=$?
	}

	restart() {
        stop
        start
	}

	reload() {
        echo -n $"Reloading $prog: "
        if [ ! -e /var/lock/nginx.lock ] || [ ! -e /var/run/nginx/nginx.pid  ]; then
            echo -n $"cannot reload $prog: nginx is not running."
            failure $"cannot reload $prog: nginx is not running."
            echo
            return 1
        fi
        kill -HUP `cat /var/run/nginx/nginx.pid ` >/dev/null 2>&1
        RETVAL=$?
        [ $RETVAL -eq 0 ] && success $"$prog reload" || failure $"$prog reload"
        echo
        return $RETVAL
	}

	case "$1" in
  	start)
        start
        ;;
  	stop)
        stop
        ;;
  	restart)
        restart
        ;;
  	reload)
        reload
        ;;
  	status)
        status
        ;;
  	link)
		netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
		;;
  	ps)
		ps -ef | grep nginx | wc -l
		;;
  	condrestart)
        [ -f /var/lock/nginx.lock ] && restart || :
        ;;
 	t)
   	    /opt/webserver/nginx/sbin/nginx -t 
   	    ;;
 	configtest)
 	       /opt/webserver/nginx/sbin/nginx -t
  	      ;;
 	 *)
        echo $"Usage: $0 {start|stop|status|reload|restart|condrestart|configtest|link|ps}"
        exit 1
	esac
