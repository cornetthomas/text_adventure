import 'package:flutter/material.dart';

class FadeReveal extends StatefulWidget {
  String title;
  String caption;

  FadeReveal(this.title, this.caption);

  @override
  FadeRevealState createState() => new FadeRevealState();
}

class FadeRevealState extends State<FadeReveal> with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
    ));

    if (_animationController.status == AnimationStatus.dismissed) {
      _animationController.forward();
    }

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: (_opacityAnimation.value),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "${widget.title}",
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: (_opacityAnimation.value),
                    child: Container(
                      padding: const EdgeInsets.all(56.0),
                      child: Center(
                        child: Text(widget.caption),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
