import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:pokeapp/util/assets.dart';

AppBar customAppBar(BuildContext context, {bool logoutButton = false}) =>
    AppBar(
      title: Image.asset(
        Assets.logoAsset,
        height: 60,
      ),
      actions: [
        if (logoutButton)
          IconButton(
              icon: Icon(Icons.logout, color: Theme.of(context).accentColor),
              onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLoggedOut()))
      ],
    );

BoxDecoration backgroundDecoration() => BoxDecoration(
    image: DecorationImage(
        image: AssetImage(Assets.backgroundAsset), fit: BoxFit.cover));

IconButton backbutton(BuildContext context) => IconButton(
    icon: Icon(Theme.of(context).platform == TargetPlatform.iOS
        ? Icons.arrow_back_ios
        : Icons.arrow_back),
    color: Theme.of(context).accentColor,
    onPressed: () => Navigator.of(context).pop());
