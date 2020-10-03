import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/bloc/pokemons_cubit/pokemons_cubit.dart';
import 'package:pokeapp/detail_cubit/detail_cubit.dart';
import 'package:pokeapp/model/pokemon.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key key}) : super(key: key);
  static const routeName = '/detailRoute';
  @override
  Widget build(BuildContext context) {
    var index = ModalRoute.of(context).settings?.arguments as int;
    var detalUrl =
        (BlocProvider.of<PokemonsCubit>(context).state as PokemonsLoaded)
            .pokemons[index]
            .url;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<DetailCubit, DetailState>(
        cubit: BlocProvider.of<DetailCubit>(context)
          ..getPokemonDetails(detalUrl),
        builder: (context, state) {
          return Container(
            child: Center(
                child: ListView(
              children: [
                TitleWidget(index),
              ],
            )),
          );
        },
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget(this.index, {Key key})
      : assert(index != null),
        super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var pokemon =
        (BlocProvider.of<PokemonsCubit>(context).state as PokemonsLoaded)
            .pokemons[index];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          child: Image.network(pokemon.imageUrl),
          tag: pokemon.id,
        ),
        Text(pokemon.name),
      ],
    );
  }
}
