import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: Theme.of(context).primaryColor,
        valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
      ),
    );
  }
}
