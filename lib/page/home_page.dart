import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:pokeapp/bloc/pokemons_cubit/pokemons_cubit.dart';
import 'package:pokeapp/model/pokemon_list.dart';
import 'package:pokeapp/page/detail_page.dart';
import 'package:pokeapp/widget/loading_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const routeName = '/homeRoute';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  bool hasReachedPoint = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                  .add(AuthenticationLoggedOut()))
        ],
      ),
      body: BlocBuilder<PokemonsCubit, PokemonsState>(
        cubit: BlocProvider.of<PokemonsCubit>(context)..fetchPokemons(),
        builder: (context, state) {
          if (state is PokemonsLoading) return LoadingWidget();
          if (state is PokemonsLoaded) {
            hasReachedPoint = false;
            return _buildPokemonList(state);
          }
          return Center(child: Text('Page not found'));
        },
      ),
    );
  }

  Widget _buildPokemonList(PokemonsLoaded state) => ListView.builder(
        controller: _scrollController,
        itemCount: state.hasReachedMax
            ? state.pokemons.length
            : state.pokemons.length + 1,
        itemBuilder: (context, index) {
          if (index < state.pokemons.length) {
            return ListTile(
                title: Text(state.pokemons[index].name),
                leading: Hero(
                    tag: state.pokemons[index].id,
                    child: Image.network(state.pokemons[index].imageUrl)),
                onTap: () => Navigator.of(context)
                    .pushNamed(DetailPage.routeName, arguments: index));
          } else {
            return Container(
              alignment: Alignment.center,
              child: Center(
                child: SizedBox(
                  width: 33,
                  height: 33,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                  ),
                ),
              ),
            );
            ;
          }
        },
      );

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold && !hasReachedPoint) {
      hasReachedPoint = true;
      BlocProvider.of<PokemonsCubit>(context).fetchPokemons();
    }
  }
}
