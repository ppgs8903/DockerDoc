# docker 常用命令
- docker version  显示 Docker 版本信息
- docker info 显示 Docker 系统信息，包括镜像和容器数
- docker-machine ip 在docker toolbox 下可以查看toolbox ip
- docler build 创建（docker build -t node/centos:v1 .）
- docker run 启动docker 容器，例子docker run --name testname -i -t centos /bin/bash
    1. -t 分配一个tty终端
    2. -i 开启stdin
    3. -d 放到后台运行 
    4. --name 容器名字
- docker start 启动容器 &name 或者 &image id
- docker attach 附着到容器上
- docker ps 列出所有运行中容器
  结合docker rm适用于(Error response from daemon: conflict: unable to delete 6036d9023b71 (must be for
ced) - image is being used by stopped container c5a3d15ed619)无法删除的情况
-  docker -rm 移除该容器