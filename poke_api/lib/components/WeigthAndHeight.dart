import 'package:flutter/material.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';

class WeigthAndHeight extends StatelessWidget {
  const WeigthAndHeight({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fitness_center, color: Colors.grey),
              Text(
                "${pokemon.weight} kg",
                style: TextStyle(
                  fontSize:
                      MediaQuery.of(context).size.width *
                      0.04,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.height, color: Colors.grey),
              Text(
                "${pokemon.height} m",
                style: TextStyle(
                  fontSize:
                      MediaQuery.of(context).size.width *
                      0.04,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
