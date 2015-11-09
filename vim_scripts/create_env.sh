#/bin/bash

function tags_build()
{
    ctags -R
    if [ ! $? -eq 0 ]; then
        echo "tags_build: generate tags file failed"
        return 1
    fi

    #使用下面的命令,为C++文件生成标签文件
    TMP=`find . -name *.cpp`
    if [ "$TMP" == "" ]; then
        echo "tags_build: doesn't have cpp file." 
    else
        ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
        if [ ! $? -eq 0 ]; then
            echo "tags_build: generate cpp table file failed"
            return 1
        fi
    fi 
    #--c++-kinds=+p : 为C++文件增加函数原型的标签
    #--fields=+iaS : 在标签文件中加入继承信息(i)、类成员的访问控制信息(a)、以及函数的指纹(S)
    #--extra=+q : 为标签增加类修饰符.注意,如果没有此选项,将不能对类成员补全
}

function tags_clean()
{
    #Clean tags files
    rm -f tags
    if [ ! $? -eq 0 ]; then
        echo "tags_clean: clean tags file failed"
        return 1
    else
        echo "tags_clean: tags file clean over"
    fi
}


function cs_build()
{
    #export all type file to cscope.files
    find . -type f > cscope.files
    if [ ! $? -eq 0 ]; then
        echo "cs_build: generate cscope.files failed"
        return 1
    fi

    cscope -bkq -i cscope.files
    if [ ! $? -eq 0 ]; then
        echo "cs_build: generate symbolic index file failed"
        return 1
    fi
}

function cs_clean()
{
    #Clean all cscope the generted files
    rm -f cscope.files cscope.in.out cscope.out cscope.po.out
    if [ ! $? -eq 0 ]; then
        echo "cs_clean: clean cscope file failed"
        return 1
    else
        echo "cs_clean: cscope file clean over"
    fi
}

function luf_build()
{
    # generate tag file for lookupfile plugin
    echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
    if [ ! $? -eq 0 ]; then
        echo "luf_build: generate filenametags file failed"
        return 1
    fi

    find . -not -regex '.*\.\(png\|gif\)' -type f -printf "%f\t%p\t1\n" | \
    sort -f >> filenametags
    if [ ! $? -eq 0 ]; then
        echo "luf_build: sort filenametags file failed"
        return 1
    fi
}

function luf_clean()
{
    #Clean all lookupfile the generate files 
    rm -f filenametags
    if [ ! $? -eq 0 ]; then
        echo "luf_clean: clean cscope file failed"
        return 1
    else
        echo "luf_clean: lookupfile file  clean over"
    fi
}

function all_build()
{
    if [ $# != 1 ]; then
        echo "param 2 is weather build cscope files use cs or nocs"
        echo "for example ./all_build cs or ./all_build nocs"
        return
    fi

    if [ $1 == "cs" ]; then
        echo "generate sccope files"
        cs_build
        if [ ! $? -eq 0 ]; then
            echo "all_build: cs_build erroe!"
            return
        fi
    elif [ $1 == "nocs" ] ;then
        echo "doesn't generate cscope files"
    else
        echo "param incorrect"
    fi
    
    tags_build
    if [ ! $? -eq 0 ]; then
        echo "all_build: tags_build error!"
        return
    fi

    luf_build
    if [ ! $? -eq 0 ]; then
        echo "all_build: luf_build error!"
        return
    fi

    echo "-----------------------------------------------"
    echo "all_build: all build successed!"
}

function all_clean()
{
    if [ $# != 2 ]; then
        echo "param 2 is weather clean cscope files use cs or nocs"
        echo "param 3 is weather clean create_env.sh use resv or noresv"
        echo "for example ./all_clean cs resv"
        return
    fi

    if [ $1 == "cs" ]; then
        echo "clean sccope files"
        cs_clean
        if [ ! $? -eq 0 ]; then
            echo "all_clean: cs_clean error!"
            return
        fi
    elif [ $1 == "nocs" ] ;then
        echo "doesn't clean cscope files"
    else
        echo "param incorrect"
    fi

    tags_clean
    if [ ! $? -eq 0 ]; then
        echo "all_clean: tags_clean error!"
        return
    fi

    luf_clean 
    if [ ! $? -eq 0 ]; then
        echo "all_clean: luf_clean error!"
        return
    fi

    if [ $2 == "noresv" ]; then
        echo "------------------------------------------------"
        echo "all_clean: clean all successed!"
        rm -f create_env.sh
    else
        echo "Keep the file create_env.sh exists"
    fi
}
