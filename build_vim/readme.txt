1.vimgdb install
Untar all files, apply the patch and make Vim:

**********************************************************
tar xjvf vim-7.4.tar.bz2 -C /tmp
tar xzvf vimgdb-for-vim7.4.tar.gz -C /tmp
cd /tmp
patch -p0 < vimgdb-for-vim7.4/vim74.patch
cd vim74/src
make
sudo make install
**********************************************************

2.Install vimGdb runtime:
Copy the file vimgdb_runtime found in the vimgdb tarball, 
to your runtime path. To find your runtime path location 
execute the vim command (this is usually $HOME/.vim): 
:set runtimepath?

**********************************************************
cp -rf /tmp/vimgdb-for-vim7.4/vimgdb_runtime/* ~/.vim
**********************************************************

Change to the doc directory, start Vim and run the ¡°:helptags .¡± 
command to process the taglist help file. Without this step, 
you cannot jump to the taglist help topics. You can now use the
 ¡°:help vimgdb¡± command to get the vimGdb documentation.