part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  final String usernameError;
  final String passwordError;

  LoginInitial({this.usernameError, this.passwordError});

  @override
  List<Object> get props => [usernameError, passwordError];
}

class LoginLoading extends LoginState {}
