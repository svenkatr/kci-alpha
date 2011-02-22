#Used to configure kernel
#Should be invoked from KERNEL_ROOT directory

config_name=$1
build_modules=$2

config_ext=".txt"
target_name="uImage"
logname="build_log_"$config_name$config_ext

make -j4 distclean > /dev/null
log_init_testcase kernel buildtests $config_name

if [ -e $KBUILDCONFIG/$config_name ]
then
  cp $KBUILDCONFIG/$config_name .config
else
  $KBUILDCONFIG/intreeconfig.sh $config_name 2>>$RESULTS_DIR/$logname
fi

scripts/config --enable CONFIG_DEBUG_SECTION_MISMATCH

compstr="$CROSS_COMPILE"gcc
make -j4 CC="$CCACHE $compstr" $target_name 2>>$RESULTS_DIR/$logname

build_success=$?
if [ $build_success == 0 ]
then
	log_finish_testcase kernel buildtests $config_name 500
	mv $BUILD_ROOT/arch/arm/boot/$target_name $RESULTS_DIR/$target_name"_"$config_name
else
	xlogtmp="see $logname for details"
	log_finish_testcase kernel buildtests $config_name 500 "$xlogtmp"
	#Log dump to console for easy grepping
	cat $RESULTS_DIR/$logname
fi

if [ $build_success == 0 -a $build_modules == 'y' ]
then
     log_init_testcase kernel buildtests $config_name"-modules"
     target_name="modules"
     modules_dir=kernelmods
     rm -fr $modules_dir
     mkdir $modules_dir
     make -j4 CC="$CCACHE $compstr" INSTALL_MOD_PATH=$modules_dir $target_name 2>>$RESULTS_DIR/$logname
     build_success=$?
     if [ $build_success == 0 ]
     then
	log_finish_testcase kernel buildtests $config_name"-modules" 200
     else
	xlogtmp="see $logname for details"
	log_finish_testcase kernel buildtests $config_name"-modules" 120 "$xlogtmp"
     fi

fi

if [ $build_success == 0 ]
then
	log_init_testcase kernel buildtests $config_name"-compiler-warnings"
	cwcount=`sort $RESULTS_DIR/$logname | uniq | grep -c "warning:"`
	echo "Warning count= $cwcount"
	if [ $cwcount -gt 10 ]
	then
	  xlogtmp="More than 10 compiler warnings!!.Warning count=$cwcount"
	  log_finish_testcase kernel buildtests $config_name"-compiler-warnings" 10 "$xlogtmp"
	else
	  log_finish_testcase kernel buildtests $config_name"-compiler-warnings" 10 
	fi
fi

