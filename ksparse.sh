#Used to do sparse tests
#Should be invoked from KERNEL_ROOT directory

config_name=$1
testcase_name=$config_name"-sparse"
config_ext=".txt"
target_name="uImage"
logname="sparse_log_"$config_name$config_ext

log_init_testcase kernel buildtests $config_name"-sparse"

if [ -e $KBUILDCONFIG/$config_name ]
then
  cp $KBUILDCONFIG/$config_name .config
else
  $KBUILDCONFIG/intreeconfig.sh $config_name 2>>$RESULTS_DIR/$logname
fi

scripts/config --enable CONFIG_DEBUG_SECTION_MISMATCH

compstr="$CROSS_COMPILE"gcc
make -j4 C=2 CC="$CCACHE $compstr" $target_name 2>>$RESULTS_DIR/$logname

build_success=$?
if [ $build_success == 0 ]
then
	swcount=`sort $RESULTS_DIR/$logname | uniq | grep -c "warning:"`
	if [ $swcount -gt 1000 ]
	then
		log_finish_testcase kernel buildtests $testcase_name 500 "More than 1000 sparse warnings!! Warning count=$swcount"
	else
		log_finish_testcase kernel buildtests $testcase_name 500
	fi
else
	xlogtmp="sparse could not be completed: See $logname for details"
	log_finish_testcase kernel buildtests $config_name 500 "$xlogtmp"
fi


