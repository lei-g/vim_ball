Ctags:

tar -xvf ctags-5.6.tar.gz

cd ctags-5.6

./configure --prefix=/usr/local/ctags

我把源码安装在/usr/local/ctags目录下

之后make && make install

最后我们需要配置下环境

sudo vi /etc/bash.bashrc

在最后添加

export PATH=/usr/local/ctags/bin:$PATH

如果编译有问题的话，直接sudo apt-get install ctags即可。
此时可执行文件是/usr/bin/ctags

需要修改.vimrc文件

然后完工

Cscope:

只需要下载cscope源码解压后，在源代码目录下执行如下命令：
./configure
make
make install

如果编译有问题的话，直接sudo apt-get install cscope即可。
此时可执行文件是/usr/bin/cscope

需要修改.vimrc文件

cscope -Rbq
命令为代码生成一个cscope数据库

