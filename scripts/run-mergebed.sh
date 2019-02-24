#!/bin/bash
outprefix=$1
shift
sortv=$1  # if 1: sort chr1, chr2, chr3, if 0: sort chr1, chr10, chr11
shift

INFILESTR=${@}
INFILES=(${INFILESTR// / })
NFILES=${#INFILES[@]}

if [ $sortv -eq "1" ]
then

    SORT_OPTION="-k1,1 -k2,2n -k3,3n -V"
    
else

    SORT_OPTION="-k1,1 -k2,2n -k3,3n"

fi

if [ $NFILES -eq 1 ]
then

    gunzip -c $INFILESTR | sort $SORT_OPTION | gzip -fc > $outprefix.bed.gz || exit

else

    # unzipping to named pipes
    arg=''
    k=1
    for f in $INFILESTR
    do
    mkfifo pp.$k
    arg="$arg pp.$k"
    gunzip -c $f | sort $SORT_OPTION > pp.$k || exit &
    let "k++"
    done
    
    # merging & compressing
    sort -m $SORT_OPTION $arg | gzip -fc -> $outprefix.bed || exit
    
    # clean up
    k=1
    for f in $INFILESTR
    do
    rm pp.$k
    let "k++"
    done

fi
