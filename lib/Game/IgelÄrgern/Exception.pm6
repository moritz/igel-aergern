use v6;

class X::Game::IgelÄrgern is Exception { }
constant XBase = X::Game::IgelÄrgern;

class X::Game::IgelÄrgern::PlayerCount is XBase {
    has Int $.count;
    has Range $.permissible;
    method message() {
        "Wrong number of players. Is $.count, should be $.permissible";
    }
}

class X::Game::IgelÄrgern::PlayerNameClash is XBase {
    has Str $.clash;
    method message() {
        "Cannot have two player named '$.clash'";
    }
}

