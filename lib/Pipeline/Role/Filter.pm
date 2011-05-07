package Pipeline::Role::Filter;
BEGIN {
	$Pipeline::VERSION = '0.01';
}

#ABSTRACT: A filter role for the pipe and filter pattern

use MooseX::Declare;

role Pipeline::Role::Filter {
	requires 'execute';
}

1;

__END__

=head1 NAME

Pipeline - A Generic Filter Role

=head1 SYNOPSIS

	{
		package MyFilter;
		use Moose;
		with 'Pipeline::Role::Filter';

		method execute {
			my ( $self, $input ) = @_;

			my $output;
			
			# Operate on $input to yield $output!
			
			return $output;
		}
	}

=head1 DESCRIPTION

An implementation of the Pipe and Filter pattern as described here
http://www.enterpriseintegrationpatterns.com/PipesAndFilters.html

=head1 REQUIRED METHODS

=head2 execute
	
The execute method is expected to take a single variable, do something with it,
and return some output.

=head1 AUTHOR

Andy Gorman <agorman@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Andy Gorman

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
