import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/model/stored_data.dart';
import 'package:pokeapp/network/pokemon_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({@required this.pokemonRepository})
      : assert(pokemonRepository != null),
        super(AuthenticationInitial());

  final PokemonRepository pokemonRepository;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationInit) {
      // Here is the checking in shared preferences is user is already logged in
      // User user = isLoggedIn();
      // if (user == null) {
      // yield AuthenticationAuthenticated();
      // } else {
      yield AuthenticationUnauthenticated();
      // }
    } else if (event is AuthenticationLoggedIn) {
      if (await _showOnboarding()) {
        yield AuthenticationShowOnBoarding();
      } else {
        yield AuthenticationAuthenticated();
      }
    } else if (event is AuthenticationLoggedOut) {
      yield AuthenticationUnauthenticated();
    } else if (event is FinishOnBoarding) {
      await _onBoardShowed();
      yield AuthenticationAuthenticated();
    }
  }

  Future<bool> _showOnboarding() async {
    var storedData = await pokemonRepository.getStoredData();
    if (storedData != null && storedData.onBoardingShowed) {
      return false;
    }
    return true;
  }

  Future<void> _onBoardShowed() async {
    await pokemonRepository.setStoredData(StoredData(onBoardingShowed: true));
  }
}
