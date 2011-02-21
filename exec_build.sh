
# invoke with one of the python configuration file as parameter
# there are some predefined settings in the settings (duh ?) directory
cd $KCI_ROOT
if [[ $1 == '' ]]
then
  echo "Build settings file not specified: Using standard configuration"
  export BUILD_CONFIG=std_build
else
  export BUILD_CONFIG=$1
fi
rm -f build_settings.py
cp settings/$BUILD_CONFIG.pl build_settings.pl
python exec_build.py
