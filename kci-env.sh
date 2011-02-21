#Explicitly unset a lot of variables to catch workspace assumption bugs
export KCI_ROOT=
export KERNEL_ROOT=
export ARCH=
export CROSS_COMPILE=

#Set variables as expected in the CI environment, for testing
export WORKSPACE=`pwd`/..
export JOB_NAME=$WORKSPACE/..
export BUILD_ID=999
