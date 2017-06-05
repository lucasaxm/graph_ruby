#!/bin/bash
for f in ../correcao/*.dot; do
    echo $f
    fsemdot=$(echo $f | cut -d '/' -f3- | cut -d '.' -f1)
    gabarito="../correcao/${fsemdot}-gabarito.txt"
    meutrab=$(mktemp)
    ./conta-caminhos < ${f} > $meutrab
    while ! [ -e $meutrab ]; do
        :
    done
    sorted1=$(mktemp mygraph.XXX)
    sorted2=$(mktemp gabarito.XXX)
    cat $meutrab | tr -d [:blank:] | grep "\[" | grep -o '.' | sort | tr -d ';' | grep '.' > $sorted1
    cat $gabarito | tr -d [:blank:] | grep "\[" | grep -o '.' | sort | tr -d ';' | grep '.' > $sorted2
    diff -s $sorted1 $sorted2
    rm $meutrab
    rm $sorted1
    rm $sorted2
done