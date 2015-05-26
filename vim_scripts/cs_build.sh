#!/bin/sh
#export all type file to cscope.files
find . -type f > cscope.files
cscope -bkq -i cscope.files
ctags -R
#使用下面的命令,为C++文件生成标签文件
ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
#--c++-kinds=+p : 为C++文件增加函数原型的标签
#--fields=+iaS : 在标签文件中加入继承信息(i)、类成员的访问控制信息(a)、以及函数的指纹(S)
#--extra=+q : 为标签增加类修饰符.注意,如果没有此选项,将不能对类成员补全

