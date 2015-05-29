#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $DIR
sh $DIR/luf_clean.sh
rm -f $DIR/luf_clean.sh
sh $DIR/cs_clean.sh 
rm -f $DIR/cs_clean.sh 
echo "------------------------------------------------"
rm -- "$0"
