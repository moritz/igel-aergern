use v6;

use Game::IgelÄrgern::Exception;
use Game::IgelÄrgern::Player;
use Game::IgelÄrgern::Board;


class Game::IgelÄrgern {
    # Construction: players join the game
    # Startup     : players place their pieces onto the start lanes
    # Play        : the actual game play phase
    # Finished    : nothing to be done anymore (presumably sombody has won)
    our enum Phase <Construction Startup Play Finished>;

    has @!players;
    has $!current-player-index;
    has Range $.permissible-player-count = 2..6;
    has Phase $.phase = Construction;

    has Game::IgelÄrgern::Board $.board = Game::IgelÄrgern::Board.new();

    method start {
        PRE { $!phase == Construction }
        self!validate-at-startup;
        $!current-player-index = @!players.keys.pick;
        $!phase = Startup;
    }

    method !validate-at-startup {
        unless @!players.elems ~~ $.permissible-player-count {
            die X::Game::IgelÄrgern::PlayerCount.new(
                count       => @!players.elems,
                permissible => $.permissible-player-count,
            );
        }
    }

    method add-player(Game::IgelÄrgern::Player $player) {
        PRE { $!phase == Construction }
        if $player === any(@!players) {
            die X::Game::IgelÄrgern::PlayerNameClash.new(
                clash   => $player.name,
            );
        }
        @!players.push: $player;
    }
}
