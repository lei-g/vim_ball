Ctags:

tar -xvf ctags-5.6.tar.gz

cd ctags-5.6

./configure --prefix=/usr/local/ctags

�Ұ�Դ�밲װ��/usr/local/ctagsĿ¼��

֮��make && make install

���������Ҫ�����»���

sudo vi /etc/bash.bashrc

��������

export PATH=/usr/local/ctags/bin:$PATH

Ȼ���깤

Cscope:

ֻ��Ҫ����cscopeԴ���ѹ����Դ����Ŀ¼��ִ���������
./configure
make
make install

cscope -Rbq
����Ϊ��������һ��cscope���ݿ�

