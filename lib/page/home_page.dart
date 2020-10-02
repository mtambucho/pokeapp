import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/bloc/pokemons_cubit/pokemons_cubit.dart';
import 'package:pokeapp/model/pokemon_list.dart';
import 'package:pokeapp/network/pokeapi_repository.dart';
import 'package:pokeapp/widget/loading_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  static const routeName = '/homeRoute';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PokemonsCubit, PokemonsState>(
          cubit: PokemonsCubit(
              pokeApiRepository:
                  RepositoryProvider.of<PokeApiRepository>(context))
            ..fetchPokemons(),
          builder: (context, state) {
            if (state is PokemonsLoading) return LoadingWidget();
            if (state is PokemonsLoaded) {
              return _buildPokemonList(state.pokemons);
            }
            return Center(child: Text('Page not found'));
          },
        ),
      ),
    );
  }

  Widget _buildPokemonList(List<PokemonItem> pokemons) => ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (context, index) => ListTile(
            title: Text(pokemons[index].name),
          ));
}
