import 'package:poke_api/features/pokemon/domain/entities/evolution_stage.dart';

class EvolutionChainParser {
  static const _spriteBase =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world';

  static List<EvolutionStage> parse(Map<String, dynamic> json) {
    final chain = json['chain'];
    if (chain == null) return const [];

    final stages = <EvolutionStage>[];
    _walk(chain, stages);
    return stages;
  }

  static void _walk(Map<String, dynamic> node, List<EvolutionStage> out) {
    final species = node['species'];
    if (species != null) {
      final id = _extractId(species['url'] ?? '');
      final rawName = (species['name'] ?? '').toString();
      final name = rawName.isEmpty
          ? rawName
          : rawName[0].toUpperCase() + rawName.substring(1);
      out.add(
        EvolutionStage(
          id: id,
          name: name,
          imageUrl: id == 0 ? '' : '$_spriteBase/$id.svg',
        ),
      );
    }

    final evolvesTo = (node['evolves_to'] as List?) ?? const [];
    for (final child in evolvesTo) {
      _walk(child as Map<String, dynamic>, out);
    }
  }

  static int _extractId(String url) {
    final match = RegExp(r'/(\d+)/?$').firstMatch(url);
    if (match == null) return 0;
    return int.tryParse(match.group(1) ?? '') ?? 0;
  }
}
