import 'package:text_adventure/character.dart';

class Player {
  String name;
  String description;
  double health;

  Player(this.name, this.description, [this.health = 100.0]);
}
