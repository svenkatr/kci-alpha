#Used to configure kernel
#Should be invoked from KERNEL_ROOT directory

if [ -e $KBUILDCONFIG/$1 ]
then
  cp $KBUILDCONFIG/$1 .config
else
  $KBUILDCONFIG/intreeconfig.sh $1
fi

