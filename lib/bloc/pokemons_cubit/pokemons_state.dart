part of 'pokemons_cubit.dart';

abstract class PokemonsState extends Equatable {
  const PokemonsState();

  @override
  List<Object> get props => [];
}

class PokemonsLoading extends PokemonsState {}

class PokemonsLoaded extends PokemonsState {
  final List<PokemonItem> pokemons;

  PokemonsLoaded(this.pokemons);

  @override
  List<Object> get props => [pokemons];
}
