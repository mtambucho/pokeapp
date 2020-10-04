import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/bloc/detail_cubit/detail_cubit.dart';
import 'package:pokeapp/bloc/pokemons_cubit/pokemons_cubit.dart';
import 'package:pokeapp/model/pokemon.dart';
import 'package:pokeapp/util/custom_colors.dart';
import 'package:pokeapp/util/strings.dart';
import 'package:pokeapp/widget/loading_widget.dart';
import 'package:pokeapp/widget/util_widgets.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key key}) : super(key: key);
  static const routeName = '/detailRoute';
  @override
  Widget build(BuildContext context) {
    var index = ModalRoute.of(context).settings?.arguments as int;

    var pokemon =
        (BlocProvider.of<PokemonsCubit>(context).state as PokemonsLoaded)
            .pokemons[index];
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: backgroundDecoration(),
      child: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            backbutton(context),
            Card(
                margin: EdgeInsets.symmetric(vertical: 75, horizontal: 10),
                color: Colors.grey.shade200,
                elevation: 10,
                child: Container(
                    width: double.infinity,
                    child: Column(children: [
                      SizedBox(height: 75),
                      Text(pokemon.name, style: TextStyle(fontSize: 20)),
                      SizedBox(height: 20),
                      InformationWidget(index: index),
                    ]))),
            Align(
              alignment: Alignment.topCenter,
              child: Hero(
                child: Image.network(
                  pokemon.imageUrl,
                  height: 150,
                  fit: BoxFit.fitHeight,
                ),
                tag: pokemon.id,
              ),
            ),
          ],
        ),
      )),
    ));
  }
}

class InformationWidget extends StatelessWidget {
  const InformationWidget({@required this.index, Key key})
      : assert(index != null),
        super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    var detalUrl =
        (BlocProvider.of<PokemonsCubit>(context).state as PokemonsLoaded)
            .pokemons[index]
            .url;
    return BlocBuilder<DetailCubit, DetailState>(
        cubit: BlocProvider.of<DetailCubit>(context)
          ..getPokemonDetails(detalUrl),
        builder: (context, state) {
          if (state.pokemon == null) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: LoadingWidget(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _buildInfoItem(
                      title: Strings.weight,
                      value: '${state.pokemon.weight}kg'),
                  _buildInfoItem(
                      title: Strings.height, value: '${state.pokemon.height}m')
                ]),
                Divider(),
                _buildTitle(Strings.abilities),
                _buildAbilities(state.pokemon.abilities),
                Divider(),
                _buildTitle(Strings.moves),
                _buildMoves(state.pokemon.moves),
              ],
            );
          }
        });
  }

  Widget _buildInfoItem({@required String title, @required String value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _detailItem(value),
          Text(
            title,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
          )
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }

  Widget _buildAbilities(List<Abilities> abilities) {
    var list = <Widget>[];
    abilities.forEach((element) {
      list.add(_detailItem(element.ability.name));
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }

  Widget _buildMoves(List<Moves> moves) {
    var list = <Widget>[];
    moves.forEach((element) {
      list.add(_detailItem(element.move.name));
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }

  Widget _detailItem(String text) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
          style: TextStyle(
              color: CustomColors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 15)));
}

class TitleWidget extends StatelessWidget {
  const TitleWidget(this.index, {Key key})
      : assert(index != null),
        super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [],
    );
  }
}
