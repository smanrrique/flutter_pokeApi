import 'package:poke_api/features/pokemon/domain/repositories/pokemon_repository.dart';

class GetFavorites {
  final PokemonRepository repository;

  const GetFavorites(this.repository);

  Future<Set<String>> call() => repository.getFavoriteUrls();
}
