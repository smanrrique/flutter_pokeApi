import 'package:poke_api/features/pokemon/domain/entities/pokemon_page.dart';
import 'package:poke_api/features/pokemon/domain/repositories/pokemon_repository.dart';

class LoadMorePokemons {
  final PokemonRepository repository;

  const LoadMorePokemons(this.repository);

  Future<PokemonPage> call(String nextUrl) => repository.loadMore(nextUrl);
}
