#!/bin/bash

#Get the absolute path of the list of testcases to execute
#For example, $KCI_ROOT/testsuite/bootuptests
selected_tests=$1
tsname=`basename $selected_tests`

cd $WORKING_DIR
cp $selected_tests $TITAN_DIR/settings/titan-selectedtests.xml
cd $TITAN_DIR

rm -f $TREPORTPATH/pdf/*.pdf
rm -f $TREPORTPATH/txt/*.txt


$TITAN_DIR/start.sh cmd $tsname | tee $RESULTS_DIR/test_log_$tsname_$TARGET_NAME".txt"

mv `ls -1 $TREPORTPATH/pdf/*.pdf` $RESULTS_DIR/test_report_$tsname_$TARGET_NAME".pdf"
#mv `ls -1 $TREPORTPATH/txt/*.txt` $RESULTS_DIR/test_result_$tsname_$TARGET_NAME".txt"

#txt_to_junit $tsname $TARGET_NAME $RESULTS_DIR/test_result_$tsname_$TARGET_NAME".txt"
txt_to_junit $tsname $TARGET_NAME `ls -1 $TREPORTPATH/txt/*.txt`
