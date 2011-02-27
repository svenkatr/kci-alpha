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
exec_sys_cmd("\$KCI_ROOT/prepare_test.sh uImage_omap2plus_defconfig bootuptests");

chdir "$ENV{'WORKING_DIR'}/Titan";
exec_sys_cmd("./start.sh cmd bootuptests");



