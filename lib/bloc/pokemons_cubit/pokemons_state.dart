part of 'pokemons_cubit.dart';

abstract class PokemonsState extends Equatable {
  const PokemonsState();

  @override
  List<Object> get props => [];
}

class PokemonsLoading extends PokemonsState {}

class PokemonsError extends PokemonsState {
  final String error;

  PokemonsError(this.error);

  @override
  List<Object> get props => [error];
}

class PokemonsLoaded extends PokemonsState {
  final List<PokemonBasicInfo> pokemons;
  // Used for pagination
  final bool hasReachedMax;

  PokemonsLoaded(this.pokemons, {this.hasReachedMax = false});

  @override
  List<Object> get props => [pokemons, hasReachedMax];
}
