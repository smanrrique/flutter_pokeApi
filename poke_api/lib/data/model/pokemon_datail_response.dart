import 'package:http/http.dart' as http;
import 'dart:convert';

class Pokemon {
  final String name;
  String url = "";
  String urlImage = "";
  List<String> listTypes = [];
  Map<String, String> mapStats = {};
  int weight = 0;
  int height = 0;

  Pokemon({required this.name, required this.url});

  static Future<Pokemon> fromJson(Map<String, dynamic> json) async {
    var namePokemon =
        json["name"].toString()[0].toUpperCase() +
        json["name"].toString().substring(1);
    final pokemon = Pokemon(name: namePokemon, url: json["url"]);
    await pokemon.getData();
    return pokemon;
  }

  Future<void> getData() async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      var decodeJson = jsonDecode(response.body);
      urlImage = decodeJson["sprites"]["other"]["dream_world"]["front_default"];

      listTypes = (decodeJson["types"] as List)
          .map((item) => item["type"]["name"].toUpperCase() as String)
          .toList();

      weight = decodeJson["weight"];
      height = decodeJson["height"];

      mapStats = {
      for (var stat in decodeJson["stats"])
        stat["stat"]["name"][0].toUpperCase() +
        stat["stat"]["name"].substring(1): stat["base_stat"].toString(),
      };
    }
  }
}
