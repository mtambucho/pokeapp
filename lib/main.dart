import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/network/pokeapi_repository.dart';
import 'package:pokeapp/page/detail_page.dart';
import 'package:pokeapp/page/home_page.dart';
import 'package:pokeapp/page/login_page.dart';
import 'package:pokeapp/page/splash_page.dart';
import 'package:pokeapp/util/simple_bloc_observer.dart';

import 'bloc/authentication_bloc/authentication_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        navigatorKey: _navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: (context, child) {
          return RepositoryProvider(
              create: (context) => PokeApiRepository(),
              child: BlocProvider<AuthenticationBloc>(
                create: (context) =>
                    AuthenticationBloc()..add(AuthenticationInit()),
                child: BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationUnauthenticated) {
                      _navigator.pushNamedAndRemoveUntil(
                          LoginPage.routeName, (_) => false);
                    } else if (state is AuthenticationAuthenticated) {
                      _navigator.pushNamedAndRemoveUntil(
                          HomePage.routeName, (_) => false);
                    }
                  },
                  child: child,
                ),
              ));
        },
        home: SplashPage(),
        routes: {
          LoginPage.routeName: (ctx) => LoginPage(),
          HomePage.routeName: (ctx) => HomePage(),
          DetailPage.routeName: (ctx) => DetailPage(),
        });
  }
}
