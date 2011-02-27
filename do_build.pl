#!/usr/bin/env perl
use strict;
use warnings;
use build_settings;

sub exec_sys_cmd
{
   my ($scmd, undef) = @_;
   my $res = system("$scmd");
}

#ARGV[0] is the KERNEL_ROOT directory passed from exec_build
chdir $ARGV[0];
exec_sys_cmd("echo \"[Kernel Version]:\"`git describe --match=v*`");

my $ca = $buildsettings{'build_configs'};
my $conf;
foreach $conf (@$ca) {
	exec_sys_cmd("\$KCI_ROOT/kbuild.sh $conf $buildsettings{'modules'}");
}

if (exists($buildsettings{'sparse'})) {
	exec_sys_cmd("\$KCI_ROOT/ksparse.sh $buildsettings{'sparse'}");
}

