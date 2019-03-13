class Position {
  int x;
  int y;

  String key;

  Position(this.x, this.y) {
    key = "$x-$y";
  }

  Position getPositionOffset(int dx, int dy) {
    Position pos = Position(x + dx, y + dy);
    return pos;
  }
}
