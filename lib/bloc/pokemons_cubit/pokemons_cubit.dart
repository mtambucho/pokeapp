import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/model/pokemon_list.dart';
import 'package:pokeapp/network/pokeapi_repository.dart';

part 'pokemons_state.dart';

class PokemonsCubit extends Cubit<PokemonsState> {
  PokemonsCubit({@required this.pokeApiRepository})
      : assert(pokeApiRepository != null),
        super(PokemonsLoading());
  final PokeApiRepository pokeApiRepository;

  Future<void> fetchPokemons() async {
    var pokemons = await pokeApiRepository.getPokemons();
    emit(PokemonsLoaded(pokemons));
  }
}
