import 'package:flutter/material.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';

class StatsPokemon extends StatelessWidget {
  const StatsPokemon({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,                      
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        childAspectRatio: 4,
        children: pokemon.mapStats.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("${entry.key}:"),
                SizedBox(width: 2),
                Text(entry.value , style: TextStyle( fontWeight: FontWeight.bold),)
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}