
# invoke with one of the configuration file as parameter
# there are some predefined settings in the settings (duh ?) directory
source kbuild-env.sh
cd $KCI_ROOT
$RESULTS_LOG= $KCI_ROOT/buildtest.xml
rm -f $RESULTS_LOG
echo "<BuildTest>" >> $RESULTS_LOG

if [[ $1 == '' ]]
then
  echo "Build settings file not specified: Using standard configuration"
  export BUILD_CONFIG=std_build
else
  export BUILD_CONFIG=$1
fi
rm -f build_settings.pm
cp settings/$BUILD_CONFIG.pl build_settings.pm
perl do_build.pl $BUILD_ROOT $RESULTS_LOG
cd $KCI_ROOT
echo "</BuildTest>" >> $RESULTS_LOG

