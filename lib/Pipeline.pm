package Pipeline;
BEGIN {
	$Pipeline::VERSION = '0.01';
}

#ABSTRACT: A pipe and filter pattern for Perl!

use MooseX::Declare;

class Pipeline {
	use MooseX::Iterator;
	use Pipeline::Types(':all');
	use Try::Tiny;

	has operations => (
		is      => 'ro',
		isa     => 'ArrayRef[IsOperation]',
		default => sub { [] },
		clearer => 'clear_operations',
		traits  => ['Array'],
		handles => {
			register         => 'push',
			total_operations => 'count',
		}
	);

	has before_filter => (
		is  => 'ro',
		isa => 'CodeRef',
	);

	has completed_operations => (
		is      => 'ro',
		isa     => 'Int',
		default => 0,
		traits  => ['Counter'],
		handles => {
			_inc_counter   => 'inc',
			_reset_counter => 'reset',
		},
	);

	method execute(@input) {
		my $iter = MooseX::Iterator::Array->new(
			collection => $self->operations,
		);

		$self->_reset_counter();

		while ($iter->has_next) {
			my $filter = $iter->next;
			$self->before_filter->($self, $filter) if ($self->before_filter);
			@input = ( $filter->execute(@input) );


			$self->_inc_counter();
		}

		return @input if wantarray;
		return shift @input;
	}
}

1;

__END__

=head1 NAME

Pipeline - The Pipe and Filter Pattern for Perl

=head1 SYNOPSIS

	use Pipeline;

	my $pipeline = Pipeline->new(
		operations => [
			Filter1->new,
			Filter2->new,
		];
	);

	my $output = $pipeline->execute($input);

=head1 DESCRIPTION

An implementation of the Pipe and Filter pattern. In this case the pipe is a
simple in memory iterator of operations (filters or pipelines).

=head1 ATTRIBUTES

=head2 operations

	is: ro, isa: ArrayRef[IsOperation]

A list of the operations to run. An Operation either consumes the
L<Pipeline::Role::Filter> role or isa L<Pipeline>.

=head2 completed_operations

	is: ro, isa: Int

A count of operations that have completed successfully.

=head2 before_filter

	is: ro, isa: CodeRef

A callback that get's executed before each filter.

	sub before_filter {
		my ( $pipeline, $next_operation ) = @_;

		printf(
			"Completed %s of %s\n",
			$pipeline->completed_operations,
			$pipeline->total_operations,
		);
	}

=head1 METHODS

=head2 execute

	(@input)
	
Takes input and passes it to the first operation's execute method. The output
from that method is passed to the next filters execute method and so on. The
last filter's output is the return value of this method.

=head2 clear_operations

Remove all registered filters.

=head2 total_operations

A count of operations registered with the pipeline.

=head1 AUTHOR

Andy Gorman <agorman@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Andy Gorman

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
