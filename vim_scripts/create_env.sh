#/bin/bash

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

    ctags -R
    if [ ! $? -eq 0 ]; then
        echo "cs_build: generate tags file failed"
        return 1
    fi

    #使用下面的命令,为C++文件生成标签文件
    TMP=`find . -name *.cpp`
    if [ "$TMP" == "" ]; then
        echo "cs_build: doesn't have cpp file." 
    else
        ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
        if [ ! $? -eq 0 ]; then
            echo "cs_build: generate cpp table file failed"
            return 1
        fi
    fi 
    #--c++-kinds=+p : 为C++文件增加函数原型的标签
    #--fields=+iaS : 在标签文件中加入继承信息(i)、类成员的访问控制信息(a)、以及函数的指纹(S)
    #--extra=+q : 为标签增加类修饰符.注意,如果没有此选项,将不能对类成员补全
}

function cs_clean()
{
    #Clean all cscope the generted files
    rm -f cscope.files cscope.in.out cscope.out cscope.po.out tags
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
    cs_build

    luf_build

    echo "-----------------------------------------------"
    echo "all_build: ll build successed!"
}

function all_clean()
{
    cs_clean

    luf_clean    

    echo "------------------------------------------------"
    echo "cll_clean: lean all successed!"
    rm -f create_env.sh
}
