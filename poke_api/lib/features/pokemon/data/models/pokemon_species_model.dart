import 'package:poke_api/features/pokemon/domain/entities/pokemon_species.dart';

class PokemonSpeciesModel extends PokemonSpecies {
  const PokemonSpeciesModel({
    required super.flavorText,
    required super.genus,
    required super.habitat,
    required super.generation,
    required super.evolutionChainUrl,
  });

  factory PokemonSpeciesModel.fromJson(Map<String, dynamic> json) {
    final flavorEntries = (json['flavor_text_entries'] as List?) ?? const [];
    final flavor = _pickLocalized(flavorEntries, 'flavor_text');

    final genusEntries = (json['genera'] as List?) ?? const [];
    final genus = _pickLocalized(genusEntries, 'genus');

    return PokemonSpeciesModel(
      flavorText: _clean(flavor),
      genus: genus,
      habitat: json['habitat']?['name'] ?? '',
      generation: json['generation']?['name'] ?? '',
      evolutionChainUrl: json['evolution_chain']?['url'] ?? '',
    );
  }

  static String _pickLocalized(List entries, String field) {
    final spanish = entries.firstWhere(
      (e) => e['language']?['name'] == 'es',
      orElse: () => null,
    );
    if (spanish != null) return spanish[field] ?? '';

    final english = entries.firstWhere(
      (e) => e['language']?['name'] == 'en',
      orElse: () => null,
    );
    if (english != null) return english[field] ?? '';

    return '';
  }

  static String _clean(String raw) =>
      raw.replaceAll('\n', ' ').replaceAll('\f', ' ').trim();
}
