import 'package:flutter/material.dart';
import 'package:pokeapp/widget/loading_widget.dart';
import 'package:pokeapp/widget/util_widgets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundDecoration(),
        child: LoadingWidget(),
      ),
    );
  }
}
