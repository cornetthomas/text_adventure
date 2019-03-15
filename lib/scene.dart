import 'package:flutter/material.dart';
import 'package:text_adventure/character.dart';
import 'package:text_adventure/enemy.dart';

class Scene {
  String title;
  String storyline;
  Color color;

  List<Character> characters = List<Character>();

  Scene(this.title, this.storyline, [this.color = Colors.black]);

  bool hasCharacters() {
    characters.removeWhere((character) => character.health == 0.0);
    return characters.isNotEmpty;
  }

  bool canContinue() {
    return hasCharacters();
  }

  bool canNavigate() {
    return !hasCharacters();
  }

  String hitEnemies(double hitPoints) {
    String response = "";

    for (Enemy enemy in characters) {
      if (enemy.hit(hitPoints) > 0) {
        response =
            response + "${enemy.name} was hit, health is ${enemy.health}";
      } else {
        response = response + "${enemy.name} was hit and died";
      }
    }
    return response;
  }
}
