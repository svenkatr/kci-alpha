
#1st param is the uImage to test
uImagename=$1

#Get the builds
#TODO: use cURL to support multiple download methods
wget --no-proxy -q  $TEST_BUILD_URL

#Don't fret if this was a direct link to the wanted uImage
if [ -f $uImagename ]
then
	echo "direct uImage link"
else
	unzip -o -qq `ls *.zip`
	if [[ $? == 0 ]]
	then
		cp `find . | grep $uImagename` uImage
	else
		echo "Could not unzip image from $TEST_BUILD_URL"
	fi
fi

wget --no-proxy -q $RESOURCES_URL"/Titan-software.tar.gz"
tar -xvf Titan-software.tar.gz > /dev/null
mv Titan-software Titan
rm -fr Titan/test_descriptors
rm -f Titan/settings/titan-selectedtests.xml
rm -f Titan/logs/*
ls -al

