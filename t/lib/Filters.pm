use MooseX::Declare;

class ReverseFilter {
	method execute($input) {
		my $output = reverse $input;
		return $output;
	}

	with 'Pipeline::Role::Filter';
}

class CapitalizeFilter {
	method execute($input) {
		return uc $input;
	}

	with 'Pipeline::Role::Filter';
}

class AdditionFilter {
	method execute(@values) {
		my $sum = 0;
		$sum += $_ for @values;
		
		return $sum;
	}

	with 'Pipeline::Role::Filter';
}

class DivideByFiveFilter {
	method execute($numerator) {
		return $numerator / 5;
	}

	with 'Pipeline::Role::Filter';
}

class SplitStringFilter {
	method execute($string) {
		return split ' ', $string;
	}

	with 'Pipeline::Role::Filter';
}

class IncrementFilter {
	method execute($num) {
		return ++$num;
	}

	with 'Pipeline::Role::Filter';
}

1;