	./redis-trib.rb add-node 192.168.0.175:6390 192.168.0.175:6391 192.168.0.175:6392
	./redis-trib.rb create --replicas 1 192.168.0.175:6390 192.168.0.175:6391 192.168.0.175:6392 192.168.0.108:6390 192.168.0.108:6391 192.168.0.108:6392

nginx 

purge CACHE

	http://blog.csdn.net/qshpeng/article/details/50930332
