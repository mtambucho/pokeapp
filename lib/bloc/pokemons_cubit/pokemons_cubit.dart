import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/model/pokemon_list.dart';
import 'package:pokeapp/network/custom_exception.dart';
import 'package:pokeapp/network/pokemon_repository.dart';

part 'pokemons_state.dart';

class PokemonsCubit extends Cubit<PokemonsState> {
  PokemonsCubit({@required this.pokemonRepository})
      : assert(pokemonRepository != null),
        super(PokemonsLoading());

  final PokemonRepository pokemonRepository;
  PokemonList _pokemonList;

  Future<void> fetchPokemons() async {
    try {
      emit(PokemonsLoading());
      var pokemonList =
          await pokemonRepository.getPokemons(url: _pokemonList?.next);

      // Copy the pokemon existing list in the new list
      pokemonList.pokemons = [
        if (_pokemonList != null) ..._pokemonList.pokemons,
        ...pokemonList?.pokemons
      ];

      _pokemonList = pokemonList;

      emit(PokemonsLoaded(_pokemonList.pokemons,
          hasReachedMax: _pokemonList.next == null));
    } catch (ex) {
      if (ex is CustomException) {
        emit(PokemonsError(ex.message));
      }
    }
  }
}
