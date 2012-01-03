# Do not edit this file - Generated by Perlito5 8.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito5::Perl5::Runtime;
use Perlito5::Perl5::Prelude;
our $MATCH = Perlito5::Match->new();
{
package GLOBAL;
    sub new { shift; bless { @_ }, "GLOBAL" }
    use v5;
    {
    package CompUnit;
        sub new { shift; bless { @_ }, "CompUnit" }
        sub name { $_[0]->{name} };
        sub body { $_[0]->{body} }
    }

;
    {
    package Val::Int;
        sub new { shift; bless { @_ }, "Val::Int" }
        sub int { $_[0]->{int} }
    }

;
    {
    package Val::Bit;
        sub new { shift; bless { @_ }, "Val::Bit" }
        sub bit { $_[0]->{bit} }
    }

;
    {
    package Val::Num;
        sub new { shift; bless { @_ }, "Val::Num" }
        sub num { $_[0]->{num} }
    }

;
    {
    package Val::Buf;
        sub new { shift; bless { @_ }, "Val::Buf" }
        sub buf { $_[0]->{buf} }
    }

;
    {
    package Lit::Block;
        sub new { shift; bless { @_ }, "Lit::Block" }
        sub sig { $_[0]->{sig} };
        sub stmts { $_[0]->{stmts} }
    }

;
    {
    package Lit::Array;
        sub new { shift; bless { @_ }, "Lit::Array" }
        sub array1 { $_[0]->{array1} }
    }

;
    {
    package Lit::Hash;
        sub new { shift; bless { @_ }, "Lit::Hash" }
        sub hash1 { $_[0]->{hash1} }
    }

;
    {
    package Index;
        sub new { shift; bless { @_ }, "Index" }
        sub obj { $_[0]->{obj} };
        sub index_exp { $_[0]->{index_exp} }
    }

;
    {
    package Lookup;
        sub new { shift; bless { @_ }, "Lookup" }
        sub obj { $_[0]->{obj} };
        sub index_exp { $_[0]->{index_exp} }
    }

;
    {
    package Var;
        sub new { shift; bless { @_ }, "Var" }
        sub sigil { $_[0]->{sigil} };
        sub twigil { $_[0]->{twigil} };
        sub namespace { $_[0]->{namespace} };
        sub name { $_[0]->{name} }
    }

;
    {
    package Proto;
        sub new { shift; bless { @_ }, "Proto" }
        sub name { $_[0]->{name} }
    }

;
    {
    package Call;
        sub new { shift; bless { @_ }, "Call" }
        sub invocant { $_[0]->{invocant} };
        sub hyper { $_[0]->{hyper} };
        sub method { $_[0]->{method} };
        sub arguments { $_[0]->{arguments} }
    }

;
    {
    package Apply;
        sub new { shift; bless { @_ }, "Apply" }
        sub code { $_[0]->{code} };
        sub arguments { $_[0]->{arguments} };
        sub namespace { $_[0]->{namespace} }
    }

;
    {
    package If;
        sub new { shift; bless { @_ }, "If" }
        sub cond { $_[0]->{cond} };
        sub body { $_[0]->{body} };
        sub otherwise { $_[0]->{otherwise} }
    }

;
    {
    package While;
        sub new { shift; bless { @_ }, "While" }
        sub init { $_[0]->{init} };
        sub cond { $_[0]->{cond} };
        sub continue { $_[0]->{continue} };
        sub body { $_[0]->{body} }
    }

;
    {
    package For;
        sub new { shift; bless { @_ }, "For" }
        sub cond { $_[0]->{cond} };
        sub body { $_[0]->{body} }
    }

;
    {
    package Decl;
        sub new { shift; bless { @_ }, "Decl" }
        sub decl { $_[0]->{decl} };
        sub type { $_[0]->{type} };
        sub var { $_[0]->{var} }
    }

;
    {
    package Sig;
        sub new { shift; bless { @_ }, "Sig" }
        sub invocant { $_[0]->{invocant} };
        sub positional { $_[0]->{positional} };
        sub named { $_[0]->{named} }
    }

;
    {
    package Sub;
        sub new { shift; bless { @_ }, "Sub" }
        sub name { $_[0]->{name} };
        sub sig { $_[0]->{sig} };
        sub block { $_[0]->{block} }
    }

;
    {
    package Do;
        sub new { shift; bless { @_ }, "Do" }
        sub block { $_[0]->{block} }
    }

;
    {
    package Use;
        sub new { shift; bless { @_ }, "Use" }
        sub mod { $_[0]->{mod} }
    }


}

1;
