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
      if (await _isAuthenticated()) {
        add(AuthenticationLoggedIn());
      } else {
        yield AuthenticationUnauthenticated();
      }
    } else if (event is AuthenticationLoggedIn) {
      if (await _showOnboarding()) {
        yield AuthenticationShowOnBoarding();
      } else {
        yield AuthenticationAuthenticated();
      }
    } else if (event is AuthenticationLoggedOut) {
      await _logout();
      yield AuthenticationUnauthenticated();
    } else if (event is FinishOnBoarding) {
      await _onBoardShowed();
      yield AuthenticationAuthenticated();
    }
  }

  Future<bool> _isAuthenticated() async {
    var storedData = await pokemonRepository.getStoredData();
    if (storedData != null && storedData.loggedIn) {
      return true;
    }
    return false;
  }

  Future<bool> _showOnboarding() async {
    var storedData = await pokemonRepository.getStoredData();
    if (storedData != null && storedData.onBoardingShowed) {
      return false;
    }
    return true;
  }

  Future<void> _onBoardShowed() async {
    var data = await pokemonRepository.getStoredData();
    data = data.copyWith(loggedIn: false);
    await pokemonRepository.setStoredData(StoredData(onBoardingShowed: true));
  }

  Future<void> _logout() async {
    var data = await pokemonRepository.getStoredData();
    data = data.copyWith(loggedIn: false);
    await pokemonRepository.setStoredData(data);
  }
}
