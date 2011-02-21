
# invoke with one of the python configuration file as parameter
# there are some predefined settings in the settings (duh ?) directory
cd $KCI_ROOT
rm -f build_settings.py
cp settings/$1.py build_settings.py
python exec_build.py
