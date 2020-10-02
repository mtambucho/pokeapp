import 'package:flutter/material.dart';
import 'package:pokeapp/model/user.dart';

abstract class PokeApiRepositoryFactory {
  User login({String username, String password});
}

class PokeApiRepository implements PokeApiRepositoryFactory {
  @override
  User login({@required String username, @required String password}) {
    //login always true
    return User(username: username);
  }
}
