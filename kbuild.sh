#Used to configure kernel
#Should be invoked from KERNEL_ROOT directory

config_name=$1
config_ext="_log.txt"
target_name="uImage"
if [ -e $KBUILDCONFIG/$config_name ]
then
  cp $KBUILDCONFIG/$config_name .config
else
  $KBUILDCONFIG/intreeconfig.sh $config_name 2>>$RESULTS_DIR/$config_name$config_ext
fi

scripts/config --enable CONFIG_DEBUG_SECTION_MISMATCH

compstr="$CROSS_COMPILE"gcc
make -j4 CC="$CCACHE $compstr" $target_name 2>>$RESULTS_DIR/$config_name$config_ext
if [ $? == 0 ]
then
	echo "Build succeeded: $config_name"
	mv $BUILD_ROOT/arch/arm/boot/$target_name $RESULTS_DIR/$target_name"_"$config_name
	echo "uImage generated for $config_name"
else
	echo "Error:Build failed: $config_name"
	echo "Complete build logs.."
	cat $RESULTS_DIR/$config_name$config_ext
fi

