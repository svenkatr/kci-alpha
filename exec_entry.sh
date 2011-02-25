
# invoke with one of the configuration file as parameter
# there are some predefined settings in the settings (duh ?) directory
source ./kbuild-env.sh
cd $KCI_ROOT
rm -fr $RESULTS_DIR
mkdir $RESULTS_DIR

log_init_testsuite kernel buildtests
if [[ $1 == '' ]]
then
  echo "configuration file not specified: Aborting "
  log_finish_testsuite kernel buildtests
  exit
else
  export BUILD_CONFIG=$1
fi
rm -f build_settings.pm
cp settings/$BUILD_CONFIG.pl build_settings.pm
perl do_build.pl $BUILD_ROOT 
cd $KCI_ROOT
rm -f build_settings.pm

log_finish_testsuite kernel buildtests

