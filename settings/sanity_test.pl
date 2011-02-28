package test_settings;
use strict;

require Exporter;
our @ISA = qw(Exporter);
our %config_settings = {};
our @EXPORT = qw(%config_settings);

$config_settings{'image'} = 'uImage_omap2plus_defconfig';
$config_settings{'testsuites'} = [ 'bootuptests' ];




