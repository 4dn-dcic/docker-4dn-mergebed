#!/bin/bash
outprefix=$1
shift

INFILESTR=${@}
INFILES=(${INFILESTR// / })
NFILES=${#INFILES[@]}

if [ $NFILES -eq 1 ]
then

    cp $1 $outprefix.bed.gz

else

    # unzipping to named pipes
    arg=''
    k=1
    for f in $INFILESTR
    do
    mkfifo pp.$k
    arg="$arg pp.$k"
    gunzip -c $f | sort -k1,1 -k2,2n > pp.$k &
    let "k++"
    done
    
    # merging 
    sort -m -k1,1 -k2,2n $arg >> $outprefix.bed
    
    # compressing
    gzip -f $outprefix.bed
    
    # clean up
    k=1
    for f in $INFILESTR
    do
    rm pp.$k
    let "k++"
    done

fi
