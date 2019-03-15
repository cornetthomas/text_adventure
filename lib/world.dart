import 'package:text_adventure/character.dart';
import 'package:text_adventure/enemy.dart';
import 'package:text_adventure/player.dart';
import 'package:text_adventure/position.dart';
import 'package:text_adventure/scene.dart';
import "package:flutter/material.dart";

enum Direction { north, south, east, west }

class World {
  String name;
  Player player;

  static final World _shared = World.shared();

  World.shared() {
    name = "Shared world";
    initWorld();
    player = Player("ThePlayer", "This is the player");
  }

  factory World() {
    return _shared;
  }

  Map<String, Scene> _scenes;
  Scene _currentScene;
  Position _currentPosition;

  void initWorld() {
    _scenes = Map();
    _scenes[Position(2, 1).key] = Scene("North", "Welcome to the North");
    _scenes[Position(1, 2).key] =
        Scene("West", "Welcome to the West", Colors.deepOrange);
    _scenes[Position(2, 2).key] = Scene("Center", "Welcome to the Center");
    _scenes[Position(3, 2).key] = Scene("East", "Welcome to the East");

    Scene aScene = Scene("South", "Welcome to the South");
    aScene.characters.add(Enemy("Troll", "This is an angry Troll", 100.0));
    _scenes[Position(2, 3).key] = aScene;

    _scenes[Position(5, 2).key] = Scene("Forest", "Welcome to the Forest");
    _scenes[Position(4, 2).key] = Scene("Beach", "Welcome to the Beach");
    _scenes[Position(4, 3).key] = Scene("Dungeon", "Welcome to the Dungeon");

    _currentPosition = Position(2, 2);
    _currentScene = _getSceneFor(_currentPosition);
  }

  Scene _getSceneFor(Position position) {
    return _scenes[position.key];
  }

  Scene getCurrentScene() {
    return _currentScene;
  }

  Scene getSceneFor(Direction direction) {
    switch (direction) {
      case Direction.north:
        _currentPosition = _currentPosition.getPositionOffset(0, -1);
        break;
      case Direction.south:
        _currentPosition = _currentPosition.getPositionOffset(0, 1);
        break;
      case Direction.east:
        _currentPosition = _currentPosition.getPositionOffset(1, 0);
        break;
      case Direction.west:
        _currentPosition = _currentPosition.getPositionOffset(-1, 0);
        break;
    }
    _currentScene = _getSceneFor(_currentPosition);

    return _currentScene;
  }

  bool hasSceneIn(Direction direction) {
    bool result = false;

    Position _position;

    switch (direction) {
      case Direction.north:
        _position = _currentPosition.getPositionOffset(0, -1);
        break;
      case Direction.south:
        _position = _currentPosition.getPositionOffset(0, 1);
        break;
      case Direction.east:
        _position = _currentPosition.getPositionOffset(1, 0);
        break;
      case Direction.west:
        _position = _currentPosition.getPositionOffset(-1, 0);
        break;
    }

    for (String key in _scenes.keys) {
      if (key == _position.key) {
        result = true;
      }
    }
    return result;
  }
}
