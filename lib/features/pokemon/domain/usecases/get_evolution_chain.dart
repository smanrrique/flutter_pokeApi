import 'package:poke_api/features/pokemon/domain/entities/evolution_stage.dart';
import 'package:poke_api/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetEvolutionChain {
  final PokemonRepository repository;

  const GetEvolutionChain(this.repository);

  Future<List<EvolutionStage>> call(String evolutionChainUrl) =>
      repository.getEvolutionChain(evolutionChainUrl);
}
