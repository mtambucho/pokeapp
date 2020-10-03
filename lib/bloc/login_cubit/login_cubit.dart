import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:pokeapp/network/pokemon_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      {@required this.pokemonRepository, @required this.authenticationBloc})
      : assert(pokemonRepository != null),
        super(LoginInitial());

  final PokemonRepository pokemonRepository;
  final AuthenticationBloc authenticationBloc;

  Future<void> logIn(String username, String password) async {
    var user =
        await pokemonRepository.login(username: username, password: password);
    if (user != null) {
      emit(LoginInitial());
      authenticationBloc.add(AuthenticationLoggedIn());
    }
  }
}
