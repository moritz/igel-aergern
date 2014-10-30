use v6;
class Game::IgelÄrgern::Player {
    has Str $.name = die "attribute 'name' is required";
    multi method WHICH(::?CLASS:D:) {
        join '|', self.^name, self.name
    }
}
