

#Get the absolute path of the list of testcases to execute
#For example, $KCI_ROOT/testsuite/bootuptests
selected_tests=$1
tsname=`basename $selected_tests`

cd $WORKING_DIR
cp $selected_tests $TITAN_DIR/settings/titan-selectedtests.xml
cd $TITAN_DIR

log_init_testsuite $tsname $TARGET_NAME 

$TITAN_DIR/start.sh cmd $tsname | tee $RESULTS_DIR/test_log_$tsname_$TARGET_NAME".txt"

log_finish_testsuite $tsname $TARGET_NAME 
