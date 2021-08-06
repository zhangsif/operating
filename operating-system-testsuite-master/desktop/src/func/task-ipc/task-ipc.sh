#! /bin/bash

TEST_DIR="bin/func/task-ipc"

echo $(basename $TEST_DIR)"-tests start!"

# mkdir report dir
REPORT_DIR="report/func/"$(basename $TEST_DIR)
mkdir -p $REPORT_DIR

ipcs -a

if [ $? -eq 0 ];then 
	echo "ipc pass"
else
    echo "ipc fail"
fi

pass=0
sum=0

for exe in `find $TEST_DIR -type f -executable ! -name "*.sh"` ; do
	# echo $(basename $exe)
	# write report
	$exe | tee $REPORT_DIR"/"$(basename $exe).txt
	if [ $? -eq 0 ] ; then  ((pass++)); fi
	let 'sum+=1'
done

echo $(basename $TEST_DIR)"-tests "$pass"/"$sum" pass"

echo $(basename $TEST_DIR)"-tests done!"
