#!/usr/bin/env perl
use strict;
use warnings;
use test_settings;

sub exec_sys_cmd
{
   my ($scmd, undef) = @_;
   my $res = system("$scmd");
}

#ARGV[0] is the directory to be used for testing
chdir $ARGV[0];
#print "Image to test $config_settings{'image'}";

if ($ENV{'TARGET_NAME'}=~/PANDA/)
{
	exec_sys_cmd("\$KCI_ROOT/panda_prepare.sh $config_settings{'image'}");
	exec_sys_cmd("\$KCI_ROOT/run_tests.sh \$KCI_ROOT/testsuite/panda_dummy");
}
 

exec_sys_cmd("\$KCI_ROOT/prepare_test.sh $config_settings{'image'}");
my $ca = $config_settings{'testsuites'};
my $conf;
foreach $conf (@$ca) {
	exec_sys_cmd("\$KCI_ROOT/run_tests.sh \$KCI_ROOT/testsuite/$conf");
}

#chdir "$ENV{'WORKING_DIR'}/Titan";
#exec_sys_cmd("./start.sh cmd bootuptests");



