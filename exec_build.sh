
# invoke with one of the configuration file as parameter
# there are some predefined settings in the settings (duh ?) directory
source kbuild-env.sh
cd $KCI_ROOT
rm -f buildtest.xml
echo "<BuildTest>" >> buildtest.xml

if [[ $1 == '' ]]
then
  echo "Build settings file not specified: Using standard configuration"
  export BUILD_CONFIG=std_build
else
  export BUILD_CONFIG=$1
fi
rm -f build_settings.pm
cp settings/$BUILD_CONFIG.pl build_settings.pm
perl do_build.pl $BUILD_ROOT
cd $KCI_ROOT
echo "</BuildTest>" >> buildtest.xml

