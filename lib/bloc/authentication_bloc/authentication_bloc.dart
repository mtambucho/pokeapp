import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

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
      yield AuthenticationAuthenticated();
    } else if (event is AuthenticationLoggedOut) {
      yield AuthenticationUnauthenticated();
    }
  }
}
