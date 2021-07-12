#!/bin/bash
ls

echo Podaj nazwę pliku wraz z rozszerzeniem:
read file

newname=$(echo $file | cut -c 1-8)
echo $newname

lines=$(wc -l < "$file")
echo Ilość wierszy w pliku: $lines


declare -i For_split
For_split=$(($lines / 10))
For_split=$(($For_split+1))

mkdir splitted

cp $file splitted

cd splitted

echo Dzielę plik na 10 części...
split -l $For_split $file $newname

rm $file

ls

echo Zmieniam nazwy plików...

mv *aa ${newname}01.txt
mv *ab ${newname}02.txt
mv *ac ${newname}03.txt
mv *ad ${newname}04.txt
mv *ae ${newname}05.txt
mv *af ${newname}06.txt
mv *ag ${newname}07.txt
mv *ah ${newname}08.txt
mv *ai ${newname}09.txt
mv *aj ${newname}10.txt

ls
