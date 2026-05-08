import 'package:poke_api/features/pokemon/domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({required super.name, required super.url});

  factory PokemonModel.fromListJson(Map<String, dynamic> json) {
    final raw = json['name'].toString();
    final capitalized = raw[0].toUpperCase() + raw.substring(1);
    return PokemonModel(name: capitalized, url: json['url']);
  }
}

class PokemonDetailDto {
  final String imageUrl;
  final String speciesUrl;
  final List<String> types;
  final Map<String, String> stats;
  final int weight;
  final int height;

  const PokemonDetailDto({
    required this.imageUrl,
    required this.speciesUrl,
    required this.types,
    required this.stats,
    required this.weight,
    required this.height,
  });

  factory PokemonDetailDto.fromJson(Map<String, dynamic> json) {
    final imageUrl =
        json['sprites']?['other']?['dream_world']?['front_default'] ?? '';

    final types = (json['types'] as List)
        .map((item) => (item['type']['name'] as String).toUpperCase())
        .toList();

    final stats = <String, String>{
      for (final stat in json['stats'] as List)
        (stat['stat']['name'].toString()[0].toUpperCase() +
                stat['stat']['name'].toString().substring(1)):
            stat['base_stat'].toString(),
    };

    return PokemonDetailDto(
      imageUrl: imageUrl,
      speciesUrl: json['species']?['url'] ?? '',
      types: types,
      stats: stats,
      weight: json['weight'] ?? 0,
      height: json['height'] ?? 0,
    );
  }
}
