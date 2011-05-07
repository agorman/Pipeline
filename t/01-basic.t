use Test::More;
use lib 't/lib';
use Pipeline;
use Filters;

# Create a pipeline object
my $pipeline = Pipeline->new(
	operations => [
		ReverseFilter->new,
	],
);

isa_ok($pipeline, 'Pipeline');


# Test reverse filter
{
	my $output = $pipeline->execute('Hello World');
	is($output, 'dlroW olleH', 'reverse filter reversed!');
}


# Test two reverse filters
{
	$pipeline->register(ReverseFilter->new);
	my $output = $pipeline->execute('Hello World');

	is($output, 'Hello World', 'double reverse filter reversed doubly!');
}

# Test two reverses and a capitalize
{
	$pipeline->register(CapitalizeFilter->new);
	my $output = $pipeline->execute('Hello World');

	is($output, 'HELLO WORLD', 'capitalize filter is yelling at me!');
}

# Test multi paramater addition filter
{
	$pipeline->clear_operations;
	$pipeline->register(AdditionFilter->new);
	my $output = $pipeline->execute(20, 5);

	is($output, 25, 'AdditionFilter successfully performed addition');
}

# Add then divide
{
	$pipeline->register(DivideByFiveFilter->new);
	my $output = $pipeline->execute(20, 5);

	is($output, 5, 'Added then Divided like a boss');
}

# Split then add
{
	$pipeline->clear_operations;
	$pipeline->register(SplitStringFilter->new);
	$pipeline->register(AdditionFilter->new);
	$pipeline->register(DivideByFiveFilter->new);
	my $output = $pipeline->execute("1 2 3 4 5");

	is($output, 3, 'Split then add!');
}
done_testing();
