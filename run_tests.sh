

#Get the absolute path of the list of testcases to execute
#For example, $KCI_ROOT/testsuite/bootuptests
selected_tests=$1

cd $WORKING_DIR
cp $selected_tests $TITAN_DIR/settings/titan-selectedtests.xml
cd $TITAN_DIR

log_init_testsuite `basename $selectedtests` $TARGET_NAME 

start.sh cmd `basename $selectedtests`

log_finish_testsuite `basename $selectedtests` $TARGET_NAME 
