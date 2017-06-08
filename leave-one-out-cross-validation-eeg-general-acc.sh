#!/bin/bash

#for running: ./leave-one-out-cross-validation-eeg.sh output.txt 3
DIR=$1
OUTFILE=$2
QUANTCLASSES=$3

SUM=0
QUANT_FILES=0

#change for the path of your python code for converting from libsvm to csv
PATH_TO_CSV_CONVERSOR="code/python/csv2libsvm.py"

#change for the path of your libsvm install
SVM_PATH="/home/eanes/workspace/libsvm-3.18/"

find $DIR -name "*.libsvm" | sort -R > leave-one-out-all-files.txt

for g in $(cat leave-one-out-all-files.txt)
do
	
	QUANT_FILES=$(echo "$QUANT_FILES + 1" | bc)

	rm leave-one-out-train.libsvm
	rm leave-one-out-test.libsvm
	
	echo " generating training file without using: $g"
	for f in $(cat leave-one-out-all-files.txt)
	do
		if [ "$g" != "$f" ]
		then
			cat $f >> leave-one-out-train.libsvm
		fi
	done
	
	$SVM_PATH/svm-scale -l -1 -u 1 -s ranges_loo.txt leave-one-out-train.libsvm > leave-one-out-train.scale.libsvm
	sort -R leave-one-out-train.scale.libsvm > leave-one-out-train.scale.libsvm.rand
	echo "running grid.py"

	python $SVM_PATH/tools/grid.py -v 10  leave-one-out-train.scale.libsvm.rand > saida_loo.txt
	last_line=$( echo $(tail -1 saida_loo.txt))
	PARAM_C=$(echo $(echo $last_line | cut -f1 -d' '))
	PARAM_G=$(echo $(echo $last_line | cut -f2 -d' '))

	cat $g > leave-one-out-test.libsvm

	$SVM_PATH/svm-scale -l -1 -u 1 -r ranges_loo.txt leave-one-out-test.libsvm > leave-one-out-test.scale.libsvm
	echo "training with C: $PARAM_C e G: $PARAM_G"
	$SVM_PATH/svm-train -b 1 -c $PARAM_C -g $PARAM_G leave-one-out-train.scale.libsvm.rand
	
	echo "predicting"
	$SVM_PATH/svm-predict -b 1 leave-one-out-test.scale.libsvm leave-one-out-train.scale.libsvm.rand.model output_acc.txt > loo_acc.txt
	last_line_acc=$( echo $(tail -1 loo_acc.txt))
	AUX_ACC=$(echo $(echo $last_line_acc | cut -f3 -d' '))
	echo "RATES for file $g: $AUX_ACC "
	echo "$g: $AUX_ACC" >> $OUTFILE
done

