import 'package:flutter/material.dart';
import 'package:pokeapp/util/assets.dart';

class LoadingWidget extends StatefulWidget {
  LoadingWidget({Key key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  AnimationController rotationController;

  @override
  void initState() {
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 900), vsync: this);
    rotationController.repeat(); // it starts the animation
    super.initState();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RotationTransition(
            turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
            child: Image.asset(Assets.pokeballAsset,
                height: 50, fit: BoxFit.fitHeight)));
  }
}
