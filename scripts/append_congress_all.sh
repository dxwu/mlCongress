#!/bin/bash

NUM=103
while [ $NUM -lt 114 ]; do
    #cp ./append_congress.sh ../pass$NUM/
    #cp ./append_congress.sh ../fail$NUM/
    #../pass$NUM/append_congress.sh $NUM
    #../fail$NUM/append_congress.sh $NUM
 
    cd ../pass$NUM
    rm *append_congress.sh
    cd ../fail$NUM
    rm *append_congress.sh
    

    let NUM=$NUM+1
done
