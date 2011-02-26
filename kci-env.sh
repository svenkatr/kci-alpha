#Explicitly unset a lot of variables to catch workspace assumption bugs
echo "Always invoke as source kci-env.sh"
export KCI_ROOT=
export KERNEL_ROOT=
export ARCH=
export CROSS_COMPILE=

#Set variables as expected in the CI environment, for testing
export RESOURCES_URL=http://omaplbp.india.ti.com:8000
export WORKSPACE=`pwd`/..
export JOB_NAME=$WORKSPACE/..
export BUILD_ID=999
export NODE_NAME=local
