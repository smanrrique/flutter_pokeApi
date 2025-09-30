import 'package:poke_api/data/model/pokemon_datail_response.dart';

class PokemonResponse {
  List<Pokemon> listPokemons;
  int count;
  String? previus;
  String next;

  PokemonResponse({
    required this.count,
    required this.previus,
    required this.next,
    required this.listPokemons,
  });

  static Future<PokemonResponse> fromJson(Map<String, dynamic> json) async {
    var list = json["results"] as List;

    List<Pokemon> pokemonList = await Future.wait(
      list.map((hero) => Pokemon.fromJson(hero)),
    );

    return PokemonResponse(
      listPokemons: pokemonList,
      count: json["count"],
      previus: json["previous"],
      next: json["next"],
    );
  }

}
