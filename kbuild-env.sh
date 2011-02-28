#!/bin/bash
#Tools environment
export KCI_ROOT=`pwd`
export KBUILDCONFIG=$KCI_ROOT/kbconfig
export ARCH=arm
export CROSS_COMPILE=arm-none-linux-gnueabi-
export CCACHE=ccache

#Infer default paths from the environment
if [[ $WORKSPACE == '' ]]
then
 echo "Warn: Workspace environment not set ?"
 exit
else
 export BUILD_ROOT=$WORKSPACE/kernel
fi

export RESULTS_DIR=$WORKSPACE/results
rm -fr $RESULTS_DIR
mkdir $RESULTS_DIR

export WORKING_DIR=$WORKSPACE/working
rm -fr $WORKING_DIR
mkdir $WORKING_DIR

export TITAN_DIR=$WORKING_DIR/Titan
export TDESCPATH=$TITAN_DIR/test_descriptors
export TUSER_SETTINGS=$TITAN_DIR/settings/user-settings.xml
export TSELECTED_TESTS=$TITAN_DIR/settings/titan-selectedtests.xml
export TLOGPATH=$TITAN_DIR/logs
export TREPORTPATH=$TITAN_DIR/reports

#Test result generation
function log_init_testsuite {
 echo "###Begin Testsuite: $*"
 filename=$RESULTS_DIR/"$1.$2".xml
 echo "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>" >$filename
 echo "<testsuite errors=\"0\" failures=\"0\" hostname=\"Jenkins\" name=\"$1.$2\" tests=\"0\" time=\"0\">" >>$filename

}

#Param1=test module name
function log_finish_testsuite {
 echo "###End Testsuite: $*"
 filename=$RESULTS_DIR/"$1.$2".xml
 #tccount=`grep -c \"testcase classname\" $1.xml`
 #tfcount=`grep -c \"failure message\" $1.xml`
 echo "</testsuite>" >>$filename
}

#Param1=test module name
#Param2=test suite name
#Param3=test case name
function log_init_testcase {
 echo "####Begin Test: $1 $2 $3"
 filename=$RESULTS_DIR/"$1.$2".xml
 start_time=`date +%s`
 echo "<testcase classname=\"$1.$2\" name=\"$3\" " >>$filename
}

#Param1=test module name
#Param2=test suite name
#Param3=test case name
#Param4=time to execute
#Param5(optional)=failure message
function log_finish_testcase {
 filename=$RESULTS_DIR/"$1.$2".xml
 current_time=`date +%s`
 diff=$(($current_time - $start_time))
 echo "time=\"$diff\"> " >>$filename
 if [ -n "$5" ]
 then
   echo "<failure message=\"$5\" /></testcase>" >>$filename
   echo "####End Test: $1 $2 $3:Fail: $5"
 else
   echo "</testcase>" >>$filename
 echo "####End Test: $1 $2 $3:Pass"
 fi

}

export -f log_init_testsuite
export -f log_finish_testsuite
export -f log_init_testcase
export -f log_finish_testcase

