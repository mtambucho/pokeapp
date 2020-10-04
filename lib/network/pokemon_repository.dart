import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pokeapp/model/pokemon.dart';
import 'package:pokeapp/model/pokemon_list.dart';
import 'package:pokeapp/model/stored_data.dart';
import 'package:pokeapp/model/user.dart';
import 'package:pokeapp/network/network_util.dart';
import 'package:pokeapp/util/constants.dart';
import 'package:pokeapp/util/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_exception.dart';

abstract class PokemonRepositoryFactory {
  Future<User> login({String username, String password});

  Future<PokemonList> getPokemons({String url});

  Future<Pokemon> getPokemonDetils(String url);

  Future<StoredData> getStoredData();

  Future<void> setStoredData(StoredData data);
}

class PokemonRepository implements PokemonRepositoryFactory {
  final NetworkUtil _netUtil = NetworkUtil();

  // Login always true
  @override
  Future<User> login(
      {@required String username, @required String password}) async {
    // Delay to make more real
    await Future.delayed(const Duration(seconds: 1));

    return User(username: username);
  }

  @override
  Future<PokemonList> getPokemons({String url}) async {
    try {
      var getPokemonUrl = url ?? Constants.kGetPokemonsUrl;
      var response = await _netUtil.get(getPokemonUrl);

      if (response.statusCode == 200) {
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        var pokemonList = PokemonList.fromJson(responseJson);
        return pokemonList;
      } else {
        throw CustomException(Strings.unexpectedServerError);
      }
    } on SocketException {
      return null;
    }
  }

  @override
  Future<Pokemon> getPokemonDetils(String url) async {
    try {
      var response = await _netUtil.get(url);

      if (response.statusCode == 200) {
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        return Pokemon.fromJson(responseJson);
      } else {
        return null;
      }
    } on SocketException {
      return null;
    }
  }

  @override
  Future<StoredData> getStoredData() async {
    var prefs = await SharedPreferences.getInstance();
    var auxStoredData = prefs.getString(Constants.kStoredData);
    final Map<String, dynamic> storedDataDecoded =
        auxStoredData != null ? json.decode(auxStoredData) : null;
    var data = storedDataDecoded != null
        ? StoredData.fromJson(storedDataDecoded)
        : null;
    return data;
  }

  @override
  Future<void> setStoredData(StoredData data) async {
    var prefs = await SharedPreferences.getInstance();
    var encodeData = json.encode(data.map);
    await prefs.setString(Constants.kStoredData, encodeData);
  }
}
