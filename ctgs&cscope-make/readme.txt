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

�������������Ļ���ֱ��sudo apt-get install ctags���ɡ�
��ʱ��ִ���ļ���/usr/bin/ctags

��Ҫ�޸�.vimrc�ļ�

Ȼ���깤

Cscope:

ֻ��Ҫ����cscopeԴ���ѹ����Դ����Ŀ¼��ִ���������
./configure
make
make install

�������������Ļ���ֱ��sudo apt-get install cscope���ɡ�
��ʱ��ִ���ļ���/usr/bin/cscope

��Ҫ�޸�.vimrc�ļ�

cscope -Rbq
����Ϊ��������һ��cscope���ݿ�

