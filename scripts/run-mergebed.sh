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
    gunzip -c $f | tail -n +2 > pp.$k &
    let "k++"
    done
    
    # header
    gunzip -c ${INFILES[0]} | head -1 > $outprefix.bed
    
    # merging 
    cat $arg >> $outprefix.bed
    
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