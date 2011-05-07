package Pipeline::Types;
BEGIN {
	$Pipeline::Types::VERSION = '0.01';
}

use strict;
use warnings;

#ABSTRACT: Type constraints for Pipeline

use Moose::Util::TypeConstraints;

subtype 'IsOperation',
	as class_type('Moose::Object'),
	where {
		$_->does('Pipeline::Role::Filter') || $_->isa('Pipeline')
	};

1;

__END__

=head1 NAME

Pipeline::Types - Types for the Pipe and Filter Pattern

=head1 TYPES

=head2 IsOperation

Either does the L<Pipeline::Role::Filter> role or isa L<Pipeline> object.

=head1 AUTHOR

Andy Gorman <agorman@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Andy Gorman

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
