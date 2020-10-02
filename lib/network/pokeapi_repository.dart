import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokeapp/model/pokemon_list.dart';
import 'package:pokeapp/model/user.dart';
import 'package:pokeapp/network/network_util.dart';
import 'package:pokeapp/util/constants.dart';

abstract class PokeApiRepositoryFactory {
  User login({String username, String password});
  Future<List<PokemonItem>> getPokemons();
}

class PokeApiRepository implements PokeApiRepositoryFactory {
  final NetworkUtil _netUtil = NetworkUtil();

  @override
  User login({@required String username, @required String password}) {
    //login always true
    return User(username: username);
  }

  @override
  Future<List<PokemonItem>> getPokemons() async {
    try {
      var response = await _netUtil.get(getPokemonsUrl);

      if (response.statusCode == 200) {
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        var pokemonList = PokemonList.fromJson(responseJson);
        return pokemonList.pokemons;
      } else {
        return null;
      }
    } on SocketException {
      return null;
    }
  }
}
