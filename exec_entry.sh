
doconfig=$1
echo $doconfig
if [[ $doconfig == *build* ]]
then
  source exec_build.sh $doconfig
elif [[ $doconfig == *test* ]]
then
  echo "Doing test"
else
  echo "Doing something else"
fi

