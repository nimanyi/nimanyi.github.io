	groupadd els
	useradd -g els els

	cd /opt/src

	wget -c https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.0.tar.gz


	chown els:els elasticsearch-6.2.0.tar.gz


	su es -c /opt/elasticsearch-2.4.3/bin/elasticsearch -Xmx2g -Xms2g -Des.index.storage.type=memory –d > /dev/null 2>&1 &


	vim ~/.bashrc

    JAVA_HOME=/opt/jdk1.8.0_161
	CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
	PATH=$JAVA_HOME/bin:$PATH
	export JAVA_HOME CLASSPATH PATH


	nohup sudo -u elsearch /usr/local/elasticsearch/bin/elasticsearch >/dev/null 2>&1 &
	

	
	wget -c https://dl.bintray.com/rabbitmq/all/rabbitmq-server/3.7.3/rabbitmq-server-3.7.3-1.el6.noarch.rpm


	su els /opt/elasticsearch/bin/elasticsearch -d -p /tmp/elasticsearch.pid 



	rpm --import http://binaries.erlang-solutions.com/debian/erlang_solutions.asc

	wget http://binaries.erlang-solutions.com/rpm/centos/erlang_solutions.repo

	mv erlang_solutions.repo /etc/yum.repos.d/  
	wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm  

	rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt  

	rabbitmqctl add_user uu898 KJH9238hasdkhIWh
    rabbitmqctl set_permissions -p "/" uu898 ".*" ".*" ".*"
	rabbitmqctl set_user_tags uu898 administrator

	http://blog.csdn.net/qq_34021712/article/details/72567786




	yum install erlang

	
	