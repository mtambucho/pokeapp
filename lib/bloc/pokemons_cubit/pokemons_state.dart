part of 'pokemons_cubit.dart';

abstract class PokemonsState extends Equatable {
  const PokemonsState();

  @override
  List<Object> get props => [];
}

class PokemonsLoading extends PokemonsState {}

class PokemonsLoaded extends PokemonsState {
  final List<PokemonBasicInfo> pokemons;
  final bool hasReachedMax;

  PokemonsLoaded(this.pokemons, {this.hasReachedMax = false});

  @override
  List<Object> get props => [pokemons, hasReachedMax];
}
