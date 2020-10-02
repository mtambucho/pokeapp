class PokemonList {
  int _count;
  String _next;
  String _previous;
  List<PokemonItem> _pokemons;

  PokemonList(
      {int count, String next, Null previous, List<PokemonItem> pokemons}) {
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
  List<PokemonItem> get pokemons => _pokemons;
  set pokemons(List<PokemonItem> pokemons) => _pokemons = pokemons;

  PokemonList.fromJson(Map<String, dynamic> json) {
    _count = json['count'];
    _next = json['next'];
    _previous = json['previous'];
    if (json['results'] != null) {
      _pokemons = <PokemonItem>[];
      json['results'].forEach((v) {
        _pokemons.add(PokemonItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['count'] = _count;
    data['next'] = _next;
    data['previous'] = _previous;
    if (_pokemons != null) {
      data['results'] = _pokemons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PokemonItem {
  String _name;
  String _url;
  String _imageUrl;

  PokemonItem({String name, String url}) {
    _name = name;
    _url = url;
    _getImageUrl();
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get url => _url;
  String get imageUrl => _imageUrl;
  set url(String url) => _url = url;

  PokemonItem.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _url = json['url'];
    _getImageUrl();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = _name;
    data['url'] = _url;
    return data;
  }

  void _getImageUrl() {
    final start = 'https://pokeapi.co/api/v2/pokemon/';
    final end = '/';
    final startIndex = _url.indexOf(start);
    final endIndex = _url.indexOf(end, startIndex + start.length);
    var id = _url.substring(startIndex + start.length, endIndex);
    _imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }
}
