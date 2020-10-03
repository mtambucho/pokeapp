class PokemonList {
  int _count;
  String _next;
  String _previous;
  List<PokemonBasicInfo> _pokemons;

  PokemonList(
      {int count,
      String next,
      Null previous,
      List<PokemonBasicInfo> pokemons}) {
    _count = count;
    _next = next;
    _previous = previous;
    _pokemons = pokemons;
  }

  int get count => _count;
  set count(int count) => _count = count;
  String get next => _next;
  set next(String next) => _next = next;
  String get previous => _previous;
  set previous(Null previous) => _previous = previous;
  List<PokemonBasicInfo> get pokemons => _pokemons;
  set pokemons(List<PokemonBasicInfo> pokemons) => _pokemons = pokemons;

  PokemonList.fromJson(Map<String, dynamic> json) {
    _count = json['count'];
    _next = json['next'];
    _previous = json['previous'];
    if (json['results'] != null) {
      _pokemons = <PokemonBasicInfo>[];
      json['results'].forEach((v) {
        _pokemons.add(PokemonBasicInfo.fromJson(v));
      });
    }
  }
}

class PokemonBasicInfo {
  int _id;
  String _name;
  String _url;
  String _imageUrl;

  PokemonBasicInfo({String name, String url}) {
    _name = name;
    _url = url;
    _getImageUrl();
  }

  int get id => _id;
  String get name =>
      '${_name.substring(0, 1).toUpperCase()}${_name.substring(1)}';
  set name(String name) => _name = name;
  String get url => _url;
  String get imageUrl => _imageUrl;
  set url(String url) => _url = url;

  PokemonBasicInfo.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _url = json['url'];
    _getImageUrl();
  }

  void _getImageUrl() {
    final start = 'https://pokeapi.co/api/v2/pokemon/';
    final end = '/';
    final startIndex = _url.indexOf(start);
    final endIndex = _url.indexOf(end, startIndex + start.length);
    var id = _url.substring(startIndex + start.length, endIndex);
    _imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
    _id = int.parse(id);
  }
}
