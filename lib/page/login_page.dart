import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:pokeapp/bloc/login_cubit/login_cubit.dart';
import 'package:pokeapp/network/pokemon_repository.dart';
import 'package:pokeapp/util/assets.dart';
import 'package:pokeapp/util/custom_colors.dart';
import 'package:pokeapp/util/strings.dart';
import 'package:pokeapp/widget/loading_widget.dart';
import 'package:pokeapp/widget/util_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  static const routeName = '/loginRoute';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit _loginCubit;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _loginCubit = LoginCubit(
        pokemonRepository: RepositoryProvider.of<PokemonRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: backgroundDecoration(),
        child: SafeArea(
          child: BlocBuilder<LoginCubit, LoginState>(
            cubit: _loginCubit,
            builder: (context, state) {
              if (state is LoginInitial) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .1),
                      Image.asset(Assets.logoAsset),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .1,
                            vertical: 10),
                        child: TextField(
                            controller: _usernameController,
                            decoration:
                                _inputDecoration(hint: Strings.username)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .1,
                            right: MediaQuery.of(context).size.width * .1,
                            top: 10,
                            bottom: 30),
                        child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration:
                                _inputDecoration(hint: Strings.password)),
                      ),
                      RaisedButton(
                          color: CustomColors.pokemonBlue.withAlpha(200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            Strings.login,
                            style: TextStyle(color: Colors.grey.shade300),
                          ),
                          onPressed: () => _loginCubit.logIn(
                              _usernameController.text,
                              _passwordController.text))
                    ],
                  ),
                );
              } else {
                return LoadingWidget();
              }
            },
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({String hint}) => InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      fillColor: Colors.grey.shade800.withAlpha(150),
      filled: true);
}
