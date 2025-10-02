import 'package:flutter/material.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';

class StatsPokemon extends StatelessWidget {
  const StatsPokemon({super.key, required this.pokemon});

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
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 8,
              left: 8,
              right: 8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${entry.key}:",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text(
                  entry.value,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
