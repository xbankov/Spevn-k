#!/bin/bash

LANGUAGE=$1

for filename in $LANGUAGE/*; do
    [ -d "$filename" ] || continue
    IFS=/ read language band <<< $filename
    echo "" > $filename.tex
    echo "\\begin{document}" >> $filename.tex
    echo "\\subsection{$band}" >> $filename.tex
    ls -l $filename | grep .tex | awk -v F=$filename '{out=""; for(i=9;i<=NF;i++){out=out" "$i}; print "\include*{"F"/"out"}"}' >> $filename.tex

    echo "\\end{document}" >> $filename.tex
done


ls -l $LANGUAGE | grep ^d | awk '{print $9}' | awk -v LANG=$LANGUAGE '{print "\subfile{"LANG"/"$1"}"}' > $LANGUAGE.tex
cat $LANGUAGE.tex

