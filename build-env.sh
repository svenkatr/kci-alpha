export KCI_ROOT=`pwd`
export ARCH=arm
export CROSS_COMPILE=arm-none-linux-gnueabi-
export CCACHE=ccache
if [[ $WORKSPACE == '' ]]
then
 echo "Warn: Not in pro environment"
else
 export KERNEL_ROOT=$WORKSPACE/kernel
fi

