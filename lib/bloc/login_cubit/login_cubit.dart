import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:pokeapp/model/stored_data.dart';
import 'package:pokeapp/network/pokemon_repository.dart';
import 'package:pokeapp/util/strings.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      {@required this.pokemonRepository, @required this.authenticationBloc})
      : assert(pokemonRepository != null),
        super(LoginInitial());

  final PokemonRepository pokemonRepository;
  final AuthenticationBloc authenticationBloc;

  Future<void> logIn(String username, String password) async {
    emit(LoginLoading());
    if (_isValid(username, password)) {
      var user =
          await pokemonRepository.login(username: username, password: password);

      if (user != null) {
        var data = await pokemonRepository.getStoredData();
        if (data != null) {
          data = data.copyWith(loggedIn: true);
        } else {
          data = StoredData(loggedIn: true);
        }
        await pokemonRepository.setStoredData(data);
        authenticationBloc.add(AuthenticationLoggedIn());
      }
    }
  }

  bool _isValid(String username, String password) {
    String usernameError, passwordError;
    if (username == null || username.isEmpty) {
      usernameError = Strings.usernameEmpty;
    }
    if (password == null || password.isEmpty) {
      passwordError = Strings.passwordEmpty;
    }
    if (passwordError != null || usernameError != null) {
      emit(LoginInitial(
          passwordError: passwordError, usernameError: usernameError));
      return false;
    }
    return true;
  }
}
