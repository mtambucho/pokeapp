part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationInit extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class FinishOnBoarding extends AuthenticationEvent {}
