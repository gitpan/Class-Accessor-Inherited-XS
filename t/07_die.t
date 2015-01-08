use Test::More;
use Class::Accessor::Inherited::XS;
use strict;

{
    package Jopa;
    use base qw/Class::Accessor::Inherited::XS/; 
    use strict;

    Jopa->mk_inherited_accessors('foo');
}

sub exception (&) {
    $@ = undef;
    eval { shift->() };
    $@
}

like exception {Jopa::foo()}, qr/Usage:/;

my $arrobj = bless [], 'Jopa';
like exception {$arrobj->foo}, qr/hash-based/;

my $scalarobj = bless \(my $z), 'Jopa';
like exception {$scalarobj->foo}, qr/hash-based/;

done_testing;
