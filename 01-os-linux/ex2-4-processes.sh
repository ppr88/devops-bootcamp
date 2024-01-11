#!/bin/bash


sorting_method=($1)
limit_proc=($2)
num_proc=($3)
ps=""

echo $sorting_method

if [ -n "$sorting_method" ]
then
	if [ $sorting_method == "-m" ]
	then
		ps=$(ps aux | grep $USER | sort -n -r -k 4)
	elif [ $sorting_method == "-c" ]
	then
		ps=$(ps aux | grep $USER | sort -n -r -k 3)
	else
		echo "Error: command $sorting_method not supported" >&2
	fi
else
	ps=$(ps aux | grep $USER)
fi


if [ -n "$limit_proc" ] 
then
	if [ $limit_proc == "-l" ]
	then
		head -n $num_proc <<< "$ps"
	else	
		echo "Error: command $limit_proc not supported" >&2
	fi
else
	printf "%s" "$ps"
fi

