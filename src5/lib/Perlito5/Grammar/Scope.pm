package Perlito5::Grammar::Scope;

use strict;

our %Special_var = (
    ARGV => 1,
    INC  => 1,
    ENV  => 1,
    SIG  => 1,
    _    => 1,
);

my @Scope;

sub new {
    return { block => [] };
}

sub new_base_scope {
    return {
        block => [
            bless({
                'name' => 'a',
                'namespace' => '',
                'sigil' => '$',
                '_decl' => 'our',
            }, 'Perlito5::AST::Var'),
            bless({
                'name' => 'b',
                'namespace' => '',
                'sigil' => '$',
                '_decl' => 'our',
            }, 'Perlito5::AST::Var'),
            # bless({
            #     'name' => '/',
            #     'namespace' => 'main',
            #     'sigil' => '$',
            #     '_decl' => 'our',
            # }, 'Perlito5::AST::Var'),
        ],
    }
}

sub create_new_compile_time_scope {
    my $new_scope = { block => [] };
    push @{ $Perlito5::SCOPE->{block} }, $new_scope;   # start new compile-time lexical scope
    push @Scope, $Perlito5::SCOPE;
    # warn "ENTER ",scalar(@Scope)," $Perlito5::PKG_NAME \n";
    $Perlito5::SCOPE = $new_scope;
}

sub end_compile_time_scope {
    # warn "EXIT  ",scalar(@Scope),"\n";
    $Perlito5::SCOPE = pop @Scope;
}

sub lookup_variable {
    # search for a variable declaration in the compile-time scope
    my $var = shift;
    ## return $var;

    return $var if $var->{namespace};       # global variable
    return $var if $var->{_decl};           # predeclared variable
    return $var if $var->{sigil} eq '&';    # &sub - TODO

    my $c = substr($var->{name}, 0, 1);
    if ( $Special_var{ $var->{name} } || $c lt 'A' || ($c gt 'Z' && $c lt 'a') || $c gt 'z') {
        # special variable
        return $var;
    }

    my $scope = shift() // $Perlito5::BASE_SCOPE;
    my $block = $scope->{block};
    if ( @$block && ref($block->[-1]) eq 'HASH' && $block->[-1]{block} ) {
        # lookup in the inner scope first
        my $look = lookup_variable($var, $block->[-1]);
        return $look if $look;
    }
    for my $item (reverse @$block) {
        if (ref($item) eq 'Perlito5::AST::Var' && $item->{_decl} && $item->{name} eq $var->{name}) {
            my $sigil = $var->{_real_sigil} || $var->{sigil};
            # TODO - namespace
            # TODO - $a[10]  $#a  ${"a"}
            # TODO - check "strict"
            if ($sigil eq $item->{sigil}) {
                # print "found name: $item->{sigil} $item->{name} decl: $item->{_decl}\n";
                return $item;
            }
        }
    }
    # print "not found\n";
    return;
}

sub check_variable_declarations {
    # examine the variables that were used in the last statement
    # - check if the variables were declared
    # - insert the variables in the current compile-time scope

    # print "env: ", Data::Dumper::Dumper( $Perlito5::SCOPE->{block} );
    for my $item ( @Perlito5::SCOPE_STMT ) {
        if (ref($item) eq 'Perlito5::AST::Var') {
            my $var = $item;
            my $look = lookup_variable($var);
            if ($look) {
                $var->{_id} = $look->{_id} if $look->{_id};
                $var->{_decl} = $look->{_decl} if $look->{_decl};
                $var->{_namespace} = $look->{_namespace} if $look->{_namespace};
            }
            else {
                # unknown variable
                if ( $Perlito5::STRICT ) {
                    # warn "look: ", Data::Dumper::Dumper(\@Perlito5::SCOPE_STMT);
                    my $sigil = $var->{_real_sigil} || $var->{sigil};
                    if ($sigil ne '*') {
                        die 'Global symbol "' . $sigil . $var->{name} . '"'
                            . ' requires explicit package name'
                            . ' at ' . $Perlito5::FILE_NAME;
                    }
                }
            }
        }
    }
    push @{ $Perlito5::SCOPE->{block} }, @Perlito5::SCOPE_STMT;
    @Perlito5::SCOPE_STMT = ();
}

sub get_snapshot {
    # return a structure with the variable declarations in the current compile-time scope
    # this is used by eval-string at runtime
    my @result;
    my $scope = shift() // $Perlito5::BASE_SCOPE;
    my $block = $scope->{block};
    if ( @$block && ref($block->[-1]) eq 'HASH' && $block->[-1]{block} ) {
        # lookup in the inner scope first
        my $look = get_snapshot($block->[-1]);
        unshift @result, @{ $look->{block} };
    }
    for my $item (@$block) {
        if (ref($item) eq 'Perlito5::AST::Var' && $item->{_decl}) {
            unshift @result, $item;
        }
    }
    return { block => \@result };
}

1;

