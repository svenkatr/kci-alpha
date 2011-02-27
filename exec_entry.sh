
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

if [[ $EXEC_CONFIG == *build* ]]
then
	rm -f build_settings.pm
	log_init_testsuite kernel buildtests
	cp settings/$EXEC_CONFIG.pl build_settings.pm
	perl do_build.pl $BUILD_ROOT $EXEC_CONFIG
	log_finish_testsuite kernel buildtests
elif [[ $EXEC_CONFIG == *test* ]]
then
	rm -f test_settings.pm
	log_init_testsuite $TARGET_NAME sanity_test
	cp settings/$EXEC_CONFIG.pl test_settings.pm
	perl do_test.pl $WORKING_DIR
	log_finish_testsuite $TARGET_NAME sanity_test
else
	echo "Could not detect config type: $EXEC_CONFIG"
fi


