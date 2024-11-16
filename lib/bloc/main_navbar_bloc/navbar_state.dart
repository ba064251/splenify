
class NavbarState {}

class NavbarInitial extends NavbarState {}

class IndexError extends NavbarState{
  final String errorMessage;

  IndexError(this.errorMessage);
}

class IndexChanged extends NavbarState{
  final int index;

  IndexChanged(this.index);
}