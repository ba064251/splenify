
class NavbarEvent {}

class ChangeIndex extends NavbarEvent{
  final int currentIndex;

  ChangeIndex(this.currentIndex);
}
