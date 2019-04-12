# 第十章中Jupyter延迟任务机制的修复过程
## 问题背景及描述
Joshua Cook的《Docker for Data Science》是一本不错的jupyter网络布局入门书，不过由于出版时间是2017年，部分软件版本与当时有所不同，造成了示例代码执行时的一些麻烦。在构建jupyter、postgresql、redis、rqworker联动延迟任务工作流时，this_worker和this_monitor两个容器无法启动，报出的错误是：

```
this_monitor_1   | Traceback (most recent call last):
this_monitor_1   |   File "/opt/conda/bin/rq-dashboard", line 11, in <module>
this_monitor_1   |     load_entry_point('rq-dashboard==0.4.0', 'console_scripts', 'rq-dashboard')()
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 489, in load_entry_point
this_monitor_1   |     return get_distribution(dist).load_entry_point(group, name)
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 2793, in load_entry_point
this_monitor_1   |     return ep.load()
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 2411, in load
this_monitor_1   |     return self.resolve()
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 2417, in resolve
this_monitor_1   |     module = __import__(self.module_name, fromlist=['__name__'], level=0)
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/rq_dashboard/__init__.py", line 3, in <module>
this_monitor_1   |     from .web import blueprint
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/rq_dashboard/web.py", line 25, in <module>
this_monitor_1   |     from rq import (Queue, Worker, cancel_job, get_failed_queue, pop_connection,
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/rq/__init__.py", line 9, in <module>
this_monitor_1   |     from .queue import get_failed_queue, Queue
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/rq/queue.py", line 61
this_monitor_1   |     async=True, job_class=None):
this_monitor_1   |         ^
this_monitor_1   | SyntaxError: invalid syntax
```
```
this_worker_1    | Traceback (most recent call last):
this_worker_1    |   File "/opt/conda/bin/rqworker", line 6, in <module>
this_worker_1    |     from rq.cli import worker
this_worker_1    |   File "/opt/conda/lib/python3.7/site-packages/rq/__init__.py                                                                                                                                                             ", line 9, in <module>
this_worker_1    |     from .queue import get_failed_queue, Queue
this_worker_1    |   File "/opt/conda/lib/python3.7/site-packages/rq/queue.py",                                                                                                                                                              line 61
this_worker_1    |     async=True, job_class=None):
this_worker_1    |         ^
this_worker_1    | SyntaxError: invalid syntax

```
## 问题解决过程
一开始怀疑是entrypoint中tini命令存在语法问题，查询了一些关于docker中multi process处理方式，发现是用的supervisor，其他关于docker process manager的贴子没给出好的解决方案，不过得知docker启动后由PID 1的主进程主导的，其他进程都应该是由PID 1衍生的子进程，若PID 1进程结束，则docker关闭。

根据网上查询到的信息，我打算进入this_jupyter容器进行测试，看看它的进程排布。于是在终端输入`jovyan@f29cf02cc4e0:~$ ps -aux`得到如下结果：
```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
jovyan       1  0.0  0.0   4524   716 ?        Ss   01:17   0:00 tini -g -- start-notebook.sh
jovyan       7  0.0  0.8  87764 69132 ?        S    01:17   0:01 /opt/conda/bin/python /opt/conda/bin/jupyter-notebook
jovyan      35  0.0  0.0  20180  3808 pts/0    Ss   01:37   0:00 /bin/bash
jovyan      70  0.0  0.0  36072  3244 pts/0    R+   02:31   0:00 ps aux
```
可以看出，this_jupyter确实由位于PID 1的进程tini进行管理。两个容器entrypoint的tini语法没有问题。于是我开始在this_jupyter中测试启动rqwork
```
jovyan@f29cf02cc4e0:~$ rqworker
Traceback (most recent call last):
  File "/opt/conda/bin/rqworker", line 6, in <module>
    from rq.cli import worker
  File "/opt/conda/lib/python3.7/site-packages/rq/__init__.py", line 9, in <module>
    from .queue import get_failed_queue, Queue
  File "/opt/conda/lib/python3.7/site-packages/rq/queue.py", line 61
    async=True, job_class=None):
        ^
SyntaxError: invalid syntax
jovyan@f29cf02cc4e0:~$ rq worker
Traceback (most recent call last):
  File "/opt/conda/bin/rq", line 6, in <module>
    from rq.cli import main
  File "/opt/conda/lib/python3.7/site-packages/rq/__init__.py", line 9, in <module>
    from .queue import get_failed_queue, Queue
  File "/opt/conda/lib/python3.7/site-packages/rq/queue.py", line 61
    async=True, job_class=None):
        ^
SyntaxError: invalid syntax
```
推测rqworker安装包有问题，于是在windows的anaconda环境中测试用conda安装rqworker，
```
(base) C:\Windows\system32>conda install --name root rq
WARNING: The conda.compat module is deprecated and will be removed in a future release.
Collecting package metadata: done
Solving environment: failed

PackagesNotFoundError: The following packages are not available from current channels:

  - rq

Current channels:

  - https://repo.anaconda.com/pkgs/main/win-64
  - https://repo.anaconda.com/pkgs/main/noarch
  - https://repo.anaconda.com/pkgs/free/win-64
  - https://repo.anaconda.com/pkgs/free/noarch
  - https://repo.anaconda.com/pkgs/r/win-64
  - https://repo.anaconda.com/pkgs/r/noarch
  - https://repo.anaconda.com/pkgs/msys2/win-64
  - https://repo.anaconda.com/pkgs/msys2/noarch

To search for alternate channels that may provide the conda package you're
looking for, navigate to

    https://anaconda.org

and use the search bar at the top of the page.
```
系统提示找不到rq包，于是尝试使用pip安装
```
(base) C:\Windows\system32>pip install rq
Collecting rq
  Downloading https://files.pythonhosted.org/packages/ee/f6/dbcf2a28e5621e1fcf6be6937da9777ad9ab03c7d3cb7d6ee835adc43329/rq-1.0-py2.py3-none-any.whl (54kB)
    100% |████████████████████████████████| 61kB 390kB/s
Collecting redis>=3.0.0 (from rq)
  Downloading https://files.pythonhosted.org/packages/ac/a7/cff10cc5f1180834a3ed564d148fb4329c989cbb1f2e196fc9a10fa07072/redis-3.2.1-py2.py3-none-any.whl (65kB)
    100% |████████████████████████████████| 71kB 891kB/s
Requirement already satisfied: click>=5.0 in c:\users\moviv\anaconda3\lib\site-packages (from rq) (7.0)
Installing collected packages: redis, rq
Successfully installed redis-3.2.1 rq-1.0
```
之后在命令行中运行rqworker
```
(base) C:\Windows\system32>rqworker
Error 10061 connecting to localhost:6379. No connection could be made because the target machine actively refused it.
```
推测Dockerfile中安装的rqworker有问题，于是修改jupyter的Dockerfile，去掉`RUN conda install --yes --name root redis rq`，增加`RUN ["bash", "-c", "source activate root && pip install rq-dashboard"]`
重新运行`docker-compose build`，系统提示：
```
Requirement already satisfied: six>=1.5 in /opt/conda/lib/python3.7/site-packages (from python-dateutil->arrow->rq-dashboard) (1.12.0)
rq-dashboard 0.4.0 has requirement rq<1.0.0,>=0.3.8, but you'll have rq 1.0 which is incompatible.
Installing collected packages: redis, rq, itsdangerous, Werkzeug, Flask, arrow, rq-dashboard
  Running setup.py install for rq-dashboard: started
    Running setup.py install for rq-dashboard: finished with status 'done'
Successfully installed Flask-1.0.2 Werkzeug-0.15.2 arrow-0.13.1 itsdangerous-1.1.0 redis-3.2.1 rq-1.0 rq-dashboard-0.4.0
```
之后运行`docker-compose up`，this_worker正常运行，this_monitor无法启动，系统提示：
```
this_monitor_1   | Traceback (most recent call last):
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 583, in _build_master
this_monitor_1   |     ws.require(__requires__)
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 900, in require
this_monitor_1   |     needed = self.resolve(parse_requirements(requirements))
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 791, in resolve
this_monitor_1   |     raise VersionConflict(dist, req).with_context(dependent_req)
this_monitor_1   | pkg_resources.ContextualVersionConflict: (rq 1.0 (/opt/conda/lib/python3.7/site-packages), Requirement.parse('rq<1.0.0,>=0.3.8'), {'rq-dashboard'})
this_monitor_1   |
this_monitor_1   | During handling of the above exception, another exception occurred:
this_monitor_1   |
this_monitor_1   | Traceback (most recent call last):
this_monitor_1   |   File "/opt/conda/bin/rq-dashboard", line 6, in <module>
this_monitor_1   |     from pkg_resources import load_entry_point
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 3191, in <module>
this_monitor_1   |     @_call_aside
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 3175, in _call_aside
this_monitor_1   |     f(*args, **kwargs)
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 3204, in_initialize_master_working_set
this_monitor_1   |     working_set = WorkingSet._build_master()
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 585, in_build_master
this_monitor_1   |     return cls._build_from_requirements(__requires__)
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 598, in _build_from_requirements
this_monitor_1   |     dists = ws.resolve(reqs, Environment())
this_monitor_1   |   File "/opt/conda/lib/python3.7/site-packages/pkg_resources/__init__.py", line 786, in resolve
this_monitor_1   |     raise DistributionNotFound(req, requirers)
this_monitor_1   | pkg_resources.DistributionNotFound: The 'rq<1.0.0,>=0.3.8' distribution was not found and is required by rq-dashboard
jupyter_this_monitor_1 exited with code 1
```
推测rq-dashboard依赖低版本的rq但pip安装的rq版本过高，于是为this_monitor单独构建docker image，在docker/jupyter文件夹中增加rq_monitor文件夹，将docker/jupyter中的docker文件复制过去，修改RUN命令为`RUN ["bash", "-c", "source activate root && pip install rq-dashboard"]`，原有Dockerfile修改为`RUN ["bash", "-c", "source activate root && pip install redis rq"]`，将根目录下docker-compose.yml修改为：
```
this_monitor:
  build: docker/jupyter/rq_monitor
  volumes:
    - .:/home/jovyan
  ports:
    - "5000:5000"
  entrypoint:
    - "tini"
    - "--"
    - "rq-dashboard"
    - "-H"
    - "this_redis"
    - "-p"
    - "5000"
```
之后启动容器`docker-compose up -d`
```
this_jupyter_1   | Executing the command: jupyter notebook
this_jupyter_1   | [I 03:16:51.287 NotebookApp] JupyterLab extension loaded from /opt/conda/lib/python3.7/site-packages/jupyterlab
this_jupyter_1   | [I 03:16:51.287 NotebookApp] JupyterLab application directory is /opt/conda/share/jupyter/lab
this_jupyter_1   | [I 03:16:51.288 NotebookApp] Serving notebooks from local directory: /home/jovyan
this_jupyter_1   | [I 03:16:51.289 NotebookApp] The Jupyter Notebook is running at:
this_jupyter_1   | [I 03:16:51.289 NotebookApp] http://(556435803bee or 127.0.0.1):8888/?token=3bf46e36717a2a181cf63005cd5c5e40151a56cb8f02b570
this_jupyter_1   | [I 03:16:51.289 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
this_jupyter_1   | [C 03:16:51.293 NotebookApp]
this_worker_1    | 03:16:48 RQ worker 'rq:worker:ff30c8fedc794f0a9205f4cff50a5df8' started, version 1.0
this_worker_1    | 03:16:48 *** Listening on default...
this_jupyter_1   |
this_jupyter_1   |     To access the notebook, open this file in a browser:
this_jupyter_1   |         file:///home/jovyan/.local/share/jupyter/runtime/nbserver-7-open.html
this_jupyter_1   |     Or copy and paste one of these URLs:
this_jupyter_1   |         http://(556435803bee or 127.0.0.1):8888/?token=3bf46e36717a2a181cf63005cd5c5e40151a56cb8f02b570
this_jupyter_1   | [I 03:16:51.895 NotebookApp] 302 GET / (103.93.180.52) 0.55ms
this_jupyter_1   | [W 03:17:08.395 NotebookApp] 404 GET http://api.ipify.org/ (223.166.75.242) 7.86ms referer=None
this_postgres_1  | 2019-04-12 03:16:46.802 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
this_postgres_1  | 2019-04-12 03:16:46.802 UTC [1] LOG:  listening on IPv6 address "::", port 5432
this_postgres_1  | 2019-04-12 03:16:46.807 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
this_postgres_1  | 2019-04-12 03:16:46.825 UTC [19] LOG:  database system was shut down at 2019-04-12 03:12:35 UTC
this_postgres_1  | 2019-04-12 03:16:46.828 UTC [1] LOG:  database system is ready to accept connections
this_monitor_1   | RQ Dashboard version 0.4.0
this_monitor_1   |  * Serving Flask app "rq_dashboard.cli" (lazy loading)
this_monitor_1   |  * Environment: production
this_monitor_1   |    WARNING: Do not use the development server in a production environment.
this_monitor_1   |    Use a production WSGI server instead.
this_monitor_1   |  * Debug mode: off
this_monitor_1   |  * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
this_redis_1     | 1:C 12 Apr 2019 03:16:47.742 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
this_redis_1     | 1:C 12 Apr 2019 03:16:47.742 # Redis version=5.0.4, bits=64, commit=00000000, modified=0, pid=1, just started
this_redis_1     | 1:C 12 Apr 2019 03:16:47.742 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
this_redis_1     | 1:M 12 Apr 2019 03:16:47.744 * Running mode=standalone, port=6379.
this_redis_1     | 1:M 12 Apr 2019 03:16:47.744 # WARNING: The TCP backlog setting of 511 cannot be enforced because /                                                                                                                       proc/sys/net/core/somaxconn is set to the lower value of 128.
this_redis_1     | 1:M 12 Apr 2019 03:16:47.744 # Server initialized
this_redis_1     | 1:M 12 Apr 2019 03:16:47.744 # WARNING overcommit_memory is set to 0! Background save may fail under low memory condition. To fix this issue add 'vm.overcommit_memory = 1' to /etc/sysctl.conf and then reboot or run the command 'sysctl vm.overcommit_memory=1' for this to take effect.
this_redis_1     | 1:M 12 Apr 2019 03:16:47.744 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never >                                                                                                                        /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
this_redis_1     | 1:M 12 Apr 2019 03:16:47.744 * DB loaded from disk: 0.000 seconds
this_redis_1     | 1:M 12 Apr 2019 03:16:47.744 * Ready to accept connections
```
所有容器成功启动。
