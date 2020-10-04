import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokeapp/model/pokemon.dart';
import 'package:pokeapp/network/pokemon_repository.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit({@required this.pokemonRepository})
      : assert(pokemonRepository != null),
        super(DetailState());

  final PokemonRepository pokemonRepository;

  Future<void> getPokemonDetails(String url) async {
    var pokemon = await pokemonRepository.getPokemonDetils(url);

    emit(DetailState(pokemon: pokemon));
  }
}
