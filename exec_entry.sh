
# invoke with one of the configuration file as parameter
# there are some predefined settings in the settings (duh ?) directory
source ./kbuild-env.sh
cd $KCI_ROOT

if [[ $1 == '' ]]
then
  echo "configuration file not specified: Aborting "
  exit
else
  export EXEC_CONFIG=$1
fi

log_init_testsuite kernel $EXEC_CONFIG
if [[ $EXEC_CONFIG == *build* ]]
then
	rm -f build_settings.pm
	cp settings/$EXEC_CONFIG.pl build_settings.pm
	perl do_build.pl $BUILD_ROOT 
	cd $KCI_ROOT
	rm -f build_settings.pm
elif [[ $EXEC_CONFIG == *test* ]]
then
	rm -f test_settings.pm
	cp settings/$EXEC_CONFIG.pl test_settings.pm
	perl do_test.pl $TEST_ROOT
else
	echo "Could not detect config type: $EXEC_CONFIG"
fi

log_finish_testsuite kernel $EXEC_CONFIG

