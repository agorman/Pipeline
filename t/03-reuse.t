use Test::More;
use lib 't/lib';
use Pipeline;
use Filters;

my $pipeline = Pipeline->new(
	operations => [
		ReverseFilter->new,
	],
);

my $string = 'reverse';

# Basic reverse test
{
	$string = $pipeline->execute($string);
	is($string, 'esrever', 'Basic Test'); 
}

# Reuse $pipeline
{
	$string = $pipeline->execute($string);
	is($string, 'reverse', 'Basic Test'); 
}

done_testing();
