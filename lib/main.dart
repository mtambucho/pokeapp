import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/detail_cubit/detail_cubit.dart';
import 'package:pokeapp/network/pokemon_repository.dart';
import 'package:pokeapp/page/detail_page.dart';
import 'package:pokeapp/page/home_page.dart';
import 'package:pokeapp/page/login_page.dart';
import 'package:pokeapp/page/onboarding_page.dart';
import 'package:pokeapp/page/splash_page.dart';
import 'package:pokeapp/util/custom_colors.dart';
import 'package:pokeapp/util/simple_bloc_observer.dart';
import 'package:pokeapp/widget/loading_widget.dart';

import 'bloc/authentication_bloc/authentication_bloc.dart';
import 'bloc/pokemons_cubit/pokemons_cubit.dart';

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
          primaryColor: Colors.grey.shade700,
          accentColor: CustomColors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        builder: (context, child) {
          return RepositoryProvider(
              create: (context) => PokemonRepository(),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<AuthenticationBloc>(
                      create: (context) => AuthenticationBloc(
                            pokemonRepository:
                                context.repository<PokemonRepository>(),
                          )..add(AuthenticationInit())),
                  BlocProvider(
                    create: (context) => PokemonsCubit(
                      pokemonRepository:
                          context.repository<PokemonRepository>(),
                    ),
                  )
                ],
                child: BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationUnauthenticated) {
                      _navigator.pushNamedAndRemoveUntil(
                          LoginPage.routeName, (_) => false);
                    } else if (state is AuthenticationAuthenticated) {
                      _navigator.pushNamedAndRemoveUntil(
                          HomePage.routeName, (_) => false);
                    } else if (state is AuthenticationShowOnBoarding) {
                      _navigator.pushNamedAndRemoveUntil(
                          OnBoardingPage.routeName, (_) => false);
                    }
                  },
                  child: child,
                ),
              ));
        },
        home: SplashPage(),
        routes: {
          LoginPage.routeName: (ctx) => LoginPage(),
          OnBoardingPage.routeName: (ctx) => OnBoardingPage(),
          HomePage.routeName: (ctx) => HomePage(),
          DetailPage.routeName: (ctx) => BlocProvider<DetailCubit>(
                create: (context) => DetailCubit(
                  pokemonRepository: context.repository<PokemonRepository>(),
                ),
                child: DetailPage(),
              ),
        });
  }
}
