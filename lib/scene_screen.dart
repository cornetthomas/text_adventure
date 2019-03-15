import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:text_adventure/enemy.dart';
import 'package:text_adventure/fade_reveal.dart';
import 'package:text_adventure/scene.dart';
import 'package:text_adventure/world.dart';

class SceneScreen extends StatefulWidget {
  final Scene scene;

  SceneScreen({Key key, this.scene}) : super(key: key);

  @override
  SceneScreenState createState() => new SceneScreenState();
}

class SceneScreenState extends State<SceneScreen> {
  String _title;
  String _storyline;

  bool canNavigate = true;

  @override
  void initState() {
    super.initState();

    _title = widget.scene.title;
    _storyline = widget.scene.storyline;
    if (widget.scene.hasCharacters()) {
      for (Enemy e in widget.scene.characters) {
        _storyline = "$_storyline. \n ${e.description}";
      }
    }

    canNavigate = widget.scene.canNavigate();
  }

  @override
  Widget build(BuildContext context) {
    canNavigate = widget.scene.canNavigate();

    return SwipeDetector(
      child: Scaffold(
        backgroundColor: widget.scene.color,
        body: SafeArea(
          child: Stack(
            children: [
              World().hasSceneIn(Direction.west) && canNavigate
                  ? Positioned(
                      child: GestureDetector(
                        onTap: () {
                          changeScene(
                            Direction.west,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("West"),
                        ),
                      ),
                      left: 3.0,
                      top: MediaQuery.of(context).size.height * 0.5,
                    )
                  : Container(),
              World().hasSceneIn(Direction.east) && canNavigate
                  ? Positioned(
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("East"),
                        ),
                        onTap: () {
                          changeScene(
                            Direction.east,
                          );
                        },
                      ),
                      right: 3.0,
                      top: MediaQuery.of(context).size.height * 0.5,
                    )
                  : Container(),
              World().hasSceneIn(Direction.north) && canNavigate
                  ? Positioned(
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("North"),
                        ),
                        onTap: () {
                          setState(() {
                            changeScene(
                              Direction.north,
                            );
                          });
                        },
                      ),
                      left: MediaQuery.of(context).size.width * 0.5 - 50.0,
                      top: 6.0,
                      width: 100.0,
                    )
                  : Container(),
              World().hasSceneIn(Direction.south) && canNavigate
                  ? Positioned(
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("South"),
                        ),
                        onTap: () {
                          changeScene(
                            Direction.south,
                          );
                        },
                      ),
                      left: MediaQuery.of(context).size.width * 0.5 - 50.0,
                      bottom: 3.0,
                      width: 100.0,
                    )
                  : Container(),
              Center(
                child: FadeReveal(_title, _storyline),
              ),
              widget.scene.hasCharacters()
                  ? Align(
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("HIT"),
                        ),
                        onTap: () {
                          setState(() {
                            _storyline = widget.scene.hitEnemies(30.0);
                          });
                        },
                      ),
                      alignment: Alignment.bottomCenter,
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      onSwipeUp: () {
        if (World().hasSceneIn(Direction.south)) {
          changeScene(
            Direction.south,
          );
        }
      },
      onSwipeDown: () {
        if (World().hasSceneIn(Direction.north)) {
          changeScene(
            Direction.north,
          );
        }
      },
      onSwipeLeft: () {
        if (World().hasSceneIn(Direction.east)) {
          changeScene(
            Direction.east,
          );
        }
      },
      onSwipeRight: () {
        if (World().hasSceneIn(Direction.west)) {
          changeScene(
            Direction.west,
          );
        }
      },
    );
  }

  void changeScene(Direction direction) {
    Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, _, __) => SceneScreen(
                scene: World().getSceneFor(direction),
              ),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: getSlideOffset(direction),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          }),
    );
  }

  Offset getSlideOffset(Direction direction) {
    switch (direction) {
      case Direction.north:
        return Offset(0.0, -1.0);
      case Direction.south:
        return Offset(0.0, 1.0);
      case Direction.east:
        return Offset(1.0, 0.0);
      case Direction.west:
        return Offset(-1.0, 0.0);
    }
  }
}
