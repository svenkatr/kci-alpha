
use warnings;
use build_settings;

#print $buildsettings{'sparse'};

my $bs = $buildsettings{'build_configs'};

for $xy (@$bs)
{
print $xy;
}

