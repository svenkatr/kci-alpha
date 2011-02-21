#!/usr/bin/env perl
use strict;
use warnings;
use build_settings;

sub exec_sys_cmd
{
   my ($scmd, undef) = @_;
   my $res = system("env && $scmd");
}

#ARGV[0] is the KERNEL_ROOT directory passed from exec_build
chdir $ARGV[0];
my $res = exec_sys_cmd('rm -f $RESULTS_DIR');

my $ca = $buildsettings{'build_configs'};
my $conf;
foreach $conf (@$ca) {
	print "Running $conf \n";
	exec_sys_cmd("\$KCI_ROOT/kbconfig.sh $conf");
}

