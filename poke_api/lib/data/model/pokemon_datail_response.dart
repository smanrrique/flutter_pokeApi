import 'package:http/http.dart' as http;
import 'dart:convert';

class Pokemon {
  final String name;
  final String url;
  String? urlImage;

  Pokemon({required this.name, required this.url, this.urlImage});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(name: json["name"], url: json["url"]);
  }

  static Future<Pokemon> fromJsonWithImage(Map<String, dynamic> json) async {

    var namePokemon = json["name"].toString()[0].toUpperCase() + json["name"].toString().substring(1) ;
    final pokemon = Pokemon(name: namePokemon, url: json["url"]);
    pokemon.urlImage = await pokemon.getImageUrl();
    return pokemon;
  }

  Future<String?> getImageUrl() async {
  final uri = Uri.parse(url);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    var decodeJson = jsonDecode(response.body);    
    return decodeJson["sprites"]["front_default"];
  }
  return null;
}
}
