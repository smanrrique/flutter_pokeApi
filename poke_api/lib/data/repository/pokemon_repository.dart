import 'dart:convert';
import 'package:poke_api/data/model/pokemon_response.dart';
import 'package:http/http.dart' as http;


class Repository {
  Future<PokemonResponse?> getPokemons() async {
   
    final uri = Uri.parse('https://pokeapi.co/api/v2/pokemon/');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var decodeJson = jsonDecode(response.body);
 
      PokemonResponse pokemonResponse = await PokemonResponse.fromJsonWithImages(
        decodeJson,
      );

      return pokemonResponse;
    } else {
      return null;
    }
  }

  Future<PokemonResponse?> loadMore(String api) async {
   
    final uri = Uri.parse(api);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var decodeJson = jsonDecode(response.body);
 
      PokemonResponse pokemonResponse = await PokemonResponse.fromJsonWithImages(
        decodeJson,
      );

      return pokemonResponse;
    } else {
      return null;
    }
  }
}
