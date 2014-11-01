use v6;

class Game::IgelÄrgern::Board::Cell {
    has Bool $.is-tarpit = False;
    has Bool $.is-goal   = False;
    has Bool $.is-start  = False;
    # @!pieces[*-1] is the top of the stack
    has @.pieces;

    multi method Str(::?CLASS:D:) {
        return 'G' if $.is-goal;
        return 'S' if $.is-start;
        return '#' if $.is-tarpit;
        return '.';
    }
}

class Game::IgelÄrgern::Board {
    has $.lanes;
    has $.length;

    # indexing into @!cells:
    # @cells[$lane][$distance-to-start]
    # where $lane ~~ ^$.lanes                 (0 = West,  $.lanes - 1 = East)
    #   and $distance-to-start ~~ ^$.length   (0 = South, $.length - 1 = North)
    has @.cells;

    our @default-tarpits = (
        [0, 3],
        [1, 6],
        [2, 4],
        [3, 5],
        [4, 2],
        [5, 7],
    );

    submethod BUILD(:$!lanes = 6, :$!length = 9, *%opts) {
        my @tarpits = %opts<tarpits>:exists
                        ?? %opts<tarpits>.list
                        !! @default-tarpits;
        my %is-tarpit;
        %is-tarpit{join '|', @$_} = True for @tarpits;

        my $goal-line = $!length - 1;
        for ^$!lanes X ^$!length -> $e, $n {
            @!cells[$e][$n] = Game::IgelÄrgern::Board::Cell.new(
                is-tarpit => ?%is-tarpit{"$e|$n"},
                is-start  => $n == 0,
                is-goal   => $n == $goal-line,
            );
        }
    }

    multi method Str(::?CLASS:D:) {
        join '', (^$!length).map( -> $idx {
            @!cells.map(*[$idx]).join ~ "\n";
        }).reverse;
    }
}
