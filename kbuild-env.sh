#Tools environment
export KCI_ROOT=`pwd`
export ARCH=arm
export CROSS_COMPILE=arm-none-linux-gnueabi-
export CCACHE=ccache

#Infer default paths from the environment
if [[ $WORKSPACE == '' ]]
then
 echo "Warn: Workspace environment not set ?"
else
 export BUILD_ROOT=$WORKSPACE/kernel
fi

export RESULTS_DIR=$BUILD_ROOT/results
