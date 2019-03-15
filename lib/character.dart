class Character {
  String name;
  String description;
  double health;

  Character(this.name, this.description, [this.health = 100.0]);

  double hit(double hitPoints) {
    health = health - hitPoints < 0.0 ? 0.0 : health - hitPoints;

    return health;
  }
}
