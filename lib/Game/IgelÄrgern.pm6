use v6;

use Game::IgelÄrgern::Exception;
use Game::IgelÄrgern::Player;

class Game::IgelÄrgern {
    has @!players;
    has $!current-player-index;
    has Range $.permissible-player-count = 2..6;

    method start {
        self!validate-at-startup;
        $!current-player-index = @!players.keys.pick;
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
        if $player === any(@!players) {
            die X::Game::IgelÄrgern::PlayerNameClash.new(
                clash   => $player.name,
            );
        }
        @!players.push: $player;
    }
}
