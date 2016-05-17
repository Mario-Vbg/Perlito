package main;

use lib 'lib5';
use strict;

BEGIN {
    $::_V6_COMPILER_NAME    = 'Perlito';
    $::_V6_COMPILER_VERSION = '1.0';
}

use Perlito::Perl5::Runtime;
use Perlito::Perl5::Match;

package Main;
use Perlito::Grammar;
use Perlito::Clojure::Emitter;
use Perlito::Grammar::Regex;
use Perlito::Emitter::Token;

my $source = join('', <> );
my $pos = 0;

say( ";; Do not edit this file - Generated by Perlito" );

while ( $pos < length( $source ) ) {
    #say( "Source code:", $source );
    my $p = Perlito::Grammar->comp_unit($source, $pos);
    #say( Main::perl( $$p ) );
    say( join( ";\n", (map { $_->emit_clojure() } ($$p) )));
    #say( $p->to, " -- ", length($source) );
    say( "" );
    $pos = $p->to;
}
