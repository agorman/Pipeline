use Test::More;
use lib 't/lib';
use Pipeline;
use Filters;

my $callbacks = 0;

my $pipeline = Pipeline->new(
	operations => [
		ReverseFilter->new,
		ReverseFilter->new,
		ReverseFilter->new,
		ReverseFilter->new,
		ReverseFilter->new,
	],
	before_filter => sub {
		my ( $self, $filter ) = @_;

		isa_ok($self,   'Pipeline');
		isa_ok($filter, 'ReverseFilter');

		$callbacks++;
	}
);

$pipeline->execute('asdf');

is($callbacks, 5, 'Correct number of callbacks');

done_testing();
