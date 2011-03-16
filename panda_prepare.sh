#!/bin/bash
#1st param is the uImage to test
uImagename=$1
rm -f $uImagename
rm -f *.zip
#Get the builds
#TODO: use cURL to support multiple download methods
wget --no-proxy -q  $TEST_BUILD_URL

#Don't fret if this was a direct link to the wanted uImage
if [ -f $uImagename ]
then
	echo "direct uImage link"
	mv $uImagename uImage
else
	unzip -o -qq `ls *.zip`
	if [[ $? == 0 ]]
	then
		cp `find . | grep $uImagename` uImage
	else
		echo "Could not unzip image from $TEST_BUILD_URL"
	fi
fi

#Assume every slave machine runs a TFTP server with the root directory as
# /tftpboot. TODO revisit this
cp uImage /usr/local/NFS/OMAP4_PANDA/target/$NODE_NAME"."$EXECUTOR_NUMBER

wget --no-proxy -q $RESOURCES_URL"/Titan-software.tar.gz"
tar -xvf Titan-software.tar.gz > /dev/null

mv Titan-software $TITAN_DIR
rm -fr $TDESCPATH
rm -f $TUSER_SETTINGS
rm -f $TSELECTED_TESTS
rm -f $TLOG_PATH

cp -r $KCI_ROOT/test_descriptors $TITAN_DIR
cp $KCI_ROOT/settings/user-settings.xml."$NODE_NAME"."$EXECUTOR_NUMBER".PANDA.LOADER $TUSER_SETTINGS

perl -p -i.bak -e 's/TDESCPATH/$ENV{'TDESCPATH'}/g' $TUSER_SETTINGS
perl -p -i.bak -e 's/NODE_NAME/$ENV{'NODE_NAME'}/g' $TUSER_SETTINGS
perl -p -i.bak -e 's/EXECUTOR_NUMBER/$ENV{'EXECUTOR_NUMBER'}/g' $TUSER_SETTINGS

cd $TITAN_DIR/test_descriptors
find . -name '*.xml' -print0 | xargs -O perl -p -i.bak -e 's/TDESCPATH/$ENV{'TDESCPATH'}/g' 
find . -name '*.xml' -print0 | xargs -O perl -p -i.bak -e 's/NODE_NAME/$ENV{'NODE_NAME'}/g'
find . -name '*.xml' -print0 | xargs -O perl -p -i.bak -e 's/EXECUTOR_NUMBER/$ENV{'EXECUTOR_NUMBER'}/g' 

