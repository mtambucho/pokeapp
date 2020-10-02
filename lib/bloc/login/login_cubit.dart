import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/bloc/authentication/authentication_bloc.dart';
import 'package:pokeapp/network/pokeapi_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      {@required this.pokeapiRepository, @required this.authenticationBloc})
      : assert(pokeapiRepository != null),
        super(LoginInitial());

  final PokeApiRepository pokeapiRepository;
  final AuthenticationBloc authenticationBloc;

  Future<void> logIn(String username, String password) async {
    var user =
        await pokeapiRepository.login(username: username, password: password);
    if (user != null) {
      emit(LoginInitial());
      authenticationBloc.add(AuthenticationLoggedIn());
    }
  }
}
