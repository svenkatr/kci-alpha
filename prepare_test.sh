
#1st param is the uImage to test
uImagename=$1
testsuitename=$2
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

#TODO Implement a mechanism to download thirdparty
#test descriptors and test lists which are not in kci-alpha
if [ $testsuitename == "sanity_test" ]
then
mv Titan-software Titan
rm -fr Titan/test_descriptors
rm -f Titan/settings/titan-selectedtests.xml
rm -f Titan/logs/*

cp -r $KCI_ROOT/test_descriptors ./Titan/
cp $KCI_ROOT/settings/user-settings.xml."$NODE_NAME"."$EXECUTOR_NUMBER" ./Titan/settings/user-settings.xml
cp $KCI_ROOT/testsuite/$testsuitename Titan/settings/titan-selectedTests.xml

else
  echo "Not implemented "

fi
