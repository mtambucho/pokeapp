class Pokemon {
  List<Abilities> _abilities;
  int _baseExperience;
  List<GameIndices> _gameIndices;
  int _height;
  bool _isDefault;
  String _locationAreaEncounters;
  List<Moves> _moves;
  int _order;
  Ability _species;
  Sprites _sprites;
  List<Stats> _stats;
  List<Types> _types;
  int _weight;

  Pokemon(
      {List<Abilities> abilities,
      int baseExperience,
      List<GameIndices> gameIndices,
      int height,
      int id,
      bool isDefault,
      String locationAreaEncounters,
      List<Moves> moves,
      String name,
      int order,
      Ability species,
      Sprites sprites,
      List<Stats> stats,
      List<Types> types,
      int weight}) {
    _abilities = abilities;
    _baseExperience = baseExperience;
    _gameIndices = gameIndices;
    _height = height;
    _isDefault = isDefault;
    _locationAreaEncounters = locationAreaEncounters;
    _moves = moves;
    _order = order;
    _species = species;
    _sprites = sprites;
    _stats = stats;
    _types = types;
    _weight = weight;
  }

  List<Abilities> get abilities => _abilities;
  set abilities(List<Abilities> abilities) => _abilities = abilities;
  int get baseExperience => _baseExperience;
  set baseExperience(int baseExperience) => _baseExperience = baseExperience;
  List<GameIndices> get gameIndices => _gameIndices;
  set gameIndices(List<GameIndices> gameIndices) => _gameIndices = gameIndices;
  int get height => _height;
  set height(int height) => _height = height;
  bool get isDefault => _isDefault;
  set isDefault(bool isDefault) => _isDefault = isDefault;
  String get locationAreaEncounters => _locationAreaEncounters;
  set locationAreaEncounters(String locationAreaEncounters) =>
      _locationAreaEncounters = locationAreaEncounters;
  List<Moves> get moves => _moves;
  set moves(List<Moves> moves) => _moves = moves;
  int get order => _order;
  set order(int order) => _order = order;
  Ability get species => _species;
  set species(Ability species) => _species = species;
  Sprites get sprites => _sprites;
  set sprites(Sprites sprites) => _sprites = sprites;
  List<Stats> get stats => _stats;
  set stats(List<Stats> stats) => _stats = stats;
  List<Types> get types => _types;
  set types(List<Types> types) => _types = types;
  int get weight => _weight;
  set weight(int weight) => _weight = weight;

  Pokemon.fromJson(Map<String, dynamic> json) {
    if (json['abilities'] != null) {
      _abilities = <Abilities>[];
      json['abilities'].forEach((v) {
        _abilities.add(Abilities.fromJson(v));
      });
    }
    _baseExperience = json['base_experience'];

    if (json['game_indices'] != null) {
      _gameIndices = <GameIndices>[];
      json['game_indices'].forEach((v) {
        _gameIndices.add(GameIndices.fromJson(v));
      });
    }
    _height = json['height'];
    _isDefault = json['is_default'];
    _locationAreaEncounters = json['location_area_encounters'];
    if (json['moves'] != null) {
      _moves = <Moves>[];
      json['moves'].forEach((v) {
        _moves.add(Moves.fromJson(v));
      });
    }
    _order = json['order'];
    _species =
        json['species'] != null ? Ability.fromJson(json['species']) : null;
    _sprites =
        json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null;
    if (json['stats'] != null) {
      _stats = <Stats>[];
      json['stats'].forEach((v) {
        _stats.add(Stats.fromJson(v));
      });
    }
    if (json['types'] != null) {
      _types = <Types>[];
      json['types'].forEach((v) {
        _types.add(Types.fromJson(v));
      });
    }
    _weight = json['weight'];
  }
}

class Abilities {
  Ability _ability;
  bool _isHidden;
  int _slot;

  Abilities({Ability ability, bool isHidden, int slot}) {
    _ability = ability;
    _isHidden = isHidden;
    _slot = slot;
  }

  Ability get ability => _ability;
  set ability(Ability ability) => _ability = ability;
  bool get isHidden => _isHidden;
  set isHidden(bool isHidden) => _isHidden = isHidden;
  int get slot => _slot;
  set slot(int slot) => _slot = slot;

  Abilities.fromJson(Map<String, dynamic> json) {
    _ability =
        json['ability'] != null ? Ability.fromJson(json['ability']) : null;
    _isHidden = json['is_hidden'];
    _slot = json['slot'];
  }
}

class Ability {
  String _name;
  String _url;

  Ability({String name, String url}) {
    _name = name;
    _url = url;
  }

  String get name => _name;
  set name(String name) => _name = name;
  String get url => _url;
  set url(String url) => _url = url;

  Ability.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _url = json['url'];
  }
}

class GameIndices {
  int _gameIndex;
  Ability _version;

  GameIndices({int gameIndex, Ability version}) {
    _gameIndex = gameIndex;
    _version = version;
  }

  int get gameIndex => _gameIndex;
  set gameIndex(int gameIndex) => _gameIndex = gameIndex;
  Ability get version => _version;
  set version(Ability version) => _version = version;

  GameIndices.fromJson(Map<String, dynamic> json) {
    _gameIndex = json['game_index'];
    _version =
        json['version'] != null ? Ability.fromJson(json['version']) : null;
  }
}

class Moves {
  Ability _move;
  List<VersionGroupDetails> _versionGroupDetails;

  Moves({Ability move, List<VersionGroupDetails> versionGroupDetails}) {
    _move = move;
    _versionGroupDetails = versionGroupDetails;
  }

  Ability get move => _move;
  set move(Ability move) => _move = move;
  List<VersionGroupDetails> get versionGroupDetails => _versionGroupDetails;
  set versionGroupDetails(List<VersionGroupDetails> versionGroupDetails) =>
      _versionGroupDetails = versionGroupDetails;

  Moves.fromJson(Map<String, dynamic> json) {
    _move = json['move'] != null ? Ability.fromJson(json['move']) : null;
    if (json['version_group_details'] != null) {
      _versionGroupDetails = <VersionGroupDetails>[];
      json['version_group_details'].forEach((v) {
        _versionGroupDetails.add(VersionGroupDetails.fromJson(v));
      });
    }
  }
}

class VersionGroupDetails {
  int _levelLearnedAt;
  Ability _moveLearnMethod;
  Ability _versionGroup;

  VersionGroupDetails(
      {int levelLearnedAt, Ability moveLearnMethod, Ability versionGroup}) {
    _levelLearnedAt = levelLearnedAt;
    _moveLearnMethod = moveLearnMethod;
    _versionGroup = versionGroup;
  }

  int get levelLearnedAt => _levelLearnedAt;
  set levelLearnedAt(int levelLearnedAt) => _levelLearnedAt = levelLearnedAt;
  Ability get moveLearnMethod => _moveLearnMethod;
  set moveLearnMethod(Ability moveLearnMethod) =>
      _moveLearnMethod = moveLearnMethod;
  Ability get versionGroup => _versionGroup;
  set versionGroup(Ability versionGroup) => _versionGroup = versionGroup;

  VersionGroupDetails.fromJson(Map<String, dynamic> json) {
    _levelLearnedAt = json['level_learned_at'];
    _moveLearnMethod = json['move_learn_method'] != null
        ? Ability.fromJson(json['move_learn_method'])
        : null;
    _versionGroup = json['version_group'] != null
        ? Ability.fromJson(json['version_group'])
        : null;
  }
}

class Sprites {
  String _backDefault;
  String _backFemale;
  String _backShiny;
  String _backShinyFemale;
  String _frontDefault;
  String _frontFemale;
  String _frontShiny;
  String _frontShinyFemale;

  Sprites({
    String backDefault,
    String backFemale,
    String backShiny,
    String backShinyFemale,
    String frontDefault,
    String frontFemale,
    String frontShiny,
    String frontShinyFemale,
  }) {
    _backDefault = backDefault;
    _backFemale = backFemale;
    _backShiny = backShiny;
    _backShinyFemale = backShinyFemale;
    _frontDefault = frontDefault;
    _frontFemale = frontFemale;
    _frontShiny = frontShiny;
    _frontShinyFemale = frontShinyFemale;
  }

  String get backDefault => _backDefault;
  set backDefault(String backDefault) => _backDefault = backDefault;
  String get backFemale => _backFemale;
  set backFemale(Null backFemale) => _backFemale = backFemale;
  String get backShiny => _backShiny;
  set backShiny(String backShiny) => _backShiny = backShiny;
  String get backShinyFemale => _backShinyFemale;
  set backShinyFemale(Null backShinyFemale) =>
      _backShinyFemale = backShinyFemale;
  String get frontDefault => _frontDefault;
  set frontDefault(String frontDefault) => _frontDefault = frontDefault;
  String get frontFemale => _frontFemale;
  set frontFemale(Null frontFemale) => _frontFemale = frontFemale;
  String get frontShiny => _frontShiny;
  set frontShiny(String frontShiny) => _frontShiny = frontShiny;
  String get frontShinyFemale => _frontShinyFemale;
  set frontShinyFemale(Null frontShinyFemale) =>
      _frontShinyFemale = frontShinyFemale;

  Sprites.fromJson(Map<String, dynamic> json) {
    _backDefault = json['back_default'];
    _backFemale = json['back_female'];
    _backShiny = json['back_shiny'];
    _backShinyFemale = json['back_shiny_female'];
    _frontDefault = json['front_default'];
    _frontFemale = json['front_female'];
    _frontShiny = json['front_shiny'];
    _frontShinyFemale = json['front_shiny_female'];
  }
}

class Stats {
  int _baseStat;
  int _effort;
  Ability _stat;

  Stats({int baseStat, int effort, Ability stat}) {
    _baseStat = baseStat;
    _effort = effort;
    _stat = stat;
  }

  int get baseStat => _baseStat;
  set baseStat(int baseStat) => _baseStat = baseStat;
  int get effort => _effort;
  set effort(int effort) => _effort = effort;
  Ability get stat => _stat;
  set stat(Ability stat) => _stat = stat;

  Stats.fromJson(Map<String, dynamic> json) {
    _baseStat = json['base_stat'];
    _effort = json['effort'];
    _stat = json['stat'] != null ? Ability.fromJson(json['stat']) : null;
  }
}

class Types {
  int _slot;
  Ability _type;

  Types({int slot, Ability type}) {
    _slot = slot;
    _type = type;
  }

  int get slot => _slot;
  set slot(int slot) => _slot = slot;
  Ability get type => _type;
  set type(Ability type) => _type = type;

  Types.fromJson(Map<String, dynamic> json) {
    _slot = json['slot'];
    _type = json['type'] != null ? Ability.fromJson(json['type']) : null;
  }
}
