use Test::More;
use lib 't/lib';
use Pipeline;
use Filters;


my $inner_pipeline = Pipeline->new(
	operations => [
		IncrementFilter->new,
		IncrementFilter->new,
		IncrementFilter->new,
		IncrementFilter->new,
		IncrementFilter->new,
	],
);

my $outer_pipeline = Pipeline->new(
	operations => [
		$inner_pipeline,
		$inner_pipeline,
	],
);

my $mixed_pipeline = Pipeline->new(
	operations => [
		$inner_pipeline,
		IncrementFilter->new,
		IncrementFilter->new,
		IncrementFilter->new,
		IncrementFilter->new,
		IncrementFilter->new,
		$inner_pipeline,
	],
);

# Simple pipeline test
{
	my $output = $inner_pipeline->execute(0);
	is($output, 5, 'Simple Test');
}

# Yo dawg, I heard you like pipelines.
{
	my $output = $outer_pipeline->execute(0);
	is($output, 10, 'Pipeline as filter');
}

# Mixed pipes & filters
{
	my $output = $mixed_pipeline->execute(0);
	is($output, 15, 'Pipelines and filters');
}


done_testing();
