
MySQL Docker 容器初始化
==


文件清单:
----

<table width="100%">
<tr><th>File Name</th><th>Description</th><th>备注</th> </tr>
<tr><td>mysql/conf/</td><td> MySQL初始化配置 </td><td>&nbsp;</td></tr>
<tr><td>mysql/initsql/dbsdevbk.sql</td><td> LIMS 的数据库初始化脚本.</td><td>&nbsp;</td></tr>
</table>



操作提示:
----

-  create folders tobe binded with container

```
mkdir -p  /home/docker/mysql/user1/data
mkdir -p  /home/docker/mysql/user1/initsql
mkdir -p  /home/docker/mysql/user1/conf
```	
- Running custom init scripts at database creation
 
copy your  **create_db.sql** into folder  **/docker-entrypoint-initdb.d**,  the sql script will be executed on container start.

```
docker run --name mysql -e MYSQL_ROOT_PASSWORD=sunway123# -d -p 3306:3306 \
	-v /home/docker/mysql/user1/data:/var/lib/mysql  \
	-v /home/docker/mysql/user1/initsql:/docker-entrypoint-initdb.d \
	-v /home/docker/mysql/user1/conf:/etc/mysql/conf.d    mysql
 
docker container exec -it mysql bash

mysql -u root -p 
密码： sunway123#

```

- chek environment variables

```
mysqladmin -u root -p variables  | grep  "case"
```

数据库初始化指南 
--
- 把数据库初始化脚本复制到指定目录 /home/docker/mysql/user1/initsql   
- /home/docker/mysql/user1/initsql  和容器内部的 /docker-entrypoint-initdb.d 是同一个目录.
- 进入容器内部:
```
docker container exec -it mysql bash 
```
- 切换到目录 /docker-entrypoint-initdb.d  你就找到了刚才copy的数据库初始脚本.
- 运行mysql
```
mysql -u root -p 
密码： sunway123#
```
- 导入数据库脚本
```
source xxxxx.sql <数据库初始化脚本> 
```


Reference
---

**Note:** 本文以MySql 8.0 为蓝本

https://github.com/docker-library/mysql/blob/7a850980c4b0d5fb5553986d280ebfb43230a6bb/8.0/Dockerfile

https://github.com/mysql/mysql-docker

- Guide:  [https://hub.docker.com/_/mysql/](https://hub.docker.com/_/mysql/)

Status
--

```
mysql> status
--------------
mysql  Ver 14.14 Distrib 5.7.19, for Linux (x86_64) using  EditLine wrapper

Connection id:          3
Current database:
Current user:           root@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         5.7.19 MySQL Community Server (GPL)
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    latin1
Db     characterset:    latin1
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/run/mysqld/mysqld.sock
Uptime:                 16 min 6 sec

Threads: 1  Questions: 6  Slow queries: 0  Opens: 105  Flush tables: 1  Open tables: 98  Queries per second avg: 0.006
```

