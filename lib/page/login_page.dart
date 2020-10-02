import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:pokeapp/bloc/login_cubit/login_cubit.dart';
import 'package:pokeapp/network/pokeapi_repository.dart';
import 'package:pokeapp/widget/loading_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  static const routeName = '/loginRoute';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit _loginCubit;

  @override
  void initState() {
    _loginCubit = LoginCubit(
        pokeapiRepository: RepositoryProvider.of<PokeApiRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LoginCubit, LoginState>(
          cubit: _loginCubit,
          builder: (context, state) {
            if (state is LoginInitial) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * .1),
                    Text('Login page'),
                    RaisedButton(
                        child: Text('login'),
                        onPressed: () => _loginCubit.logIn('username', '123'))
                  ],
                ),
              );
            } else {
              return LoadingWidget();
            }
          },
        ),
      ),
    );
  }
}
