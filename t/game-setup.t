use Test;

BEGIN plan 5;

use Game::IgelÄrgern;
use Game::IgelÄrgern::Player;
use Game::IgelÄrgern::Exception;

sub g(|a) { Game::IgelÄrgern.new(|a) }
sub p($name) { Game::IgelÄrgern::Player.new(name => $name) }


{
    throws_like { g.start },
        X::Game::IgelÄrgern::PlayerCount,
        count => 0,
    ;
}

{
    my $game = g;
    $game.add-player(p 'Flo');
    throws_like {
            $game.add-player(p 'Flo');
        },
        X::Game::IgelÄrgern::PlayerNameClash,
        clash => 'Flo',
        ;
};

{
    my $game = g;
    $game.add-player(p $_) for <Flo Annika Moritz>;
    lives_ok { $game.start }, 'can start a game with three different players';
    is $game.board.Str, q:to/BOARD/, 'correct default board';
        GGGGGG
        .....#
        .#....
        ...#..
        ..#...
        #.....
        ....#.
        ......
        SSSSSS
        BOARD
    dies_ok { $game.start }, 'Cannot start an already-stared game';
}
