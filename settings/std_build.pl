#!/usr/bin/env perl

package build_settings;
use strict;
require Exporter;

our @ISA = qw(Exporter);
our %buildsettings;
our @EXPORT = qw(%buildsettings);

%buildsettings = {};
$buildsettings{'build_configs'} = [ 'omap1_defconfig', 'omap2plus_defconfig' ];
$buildsettings{'sparse'}= 'y';
$buildsettings{'checkpatch'}='n';

1;
