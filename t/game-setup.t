use Test;

BEGIN plan 2;

use Game::IgelÄrgern;
use Game::IgelÄrgern::Player;
use Game::IgelÄrgern::Exception;


{
    my $game = Game::IgelÄrgern.new();
    throws_like { $game.start },
        X::Game::IgelÄrgern::PlayerCount,
        count => 0,
    ;
}

{
    my $game = Game::IgelÄrgern.new();
    $game.add-player(Game::IgelÄrgern::Player.new(name => 'Flo'));
    throws_like {
            $game.add-player(Game::IgelÄrgern::Player.new(name => 'Flo'))
        },
        X::Game::IgelÄrgern::PlayerNameClash,
        clash => 'Flo',
        ;

};
