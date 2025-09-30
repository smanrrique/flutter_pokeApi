import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_api/components/StatsPokemon.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';
import 'package:poke_api/utils/app_colors.dart';

class ModalDetailPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const ModalDetailPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 8,
                  right: 8,
                  bottom: 8,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      pokemon.name,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 12,
                      children: pokemon.listTypes.map((nombre) {
                        return Container(
                          decoration: BoxDecoration(
                            color:
                                AppColors.typesPokemonColor[nombre] ??
                                Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              nombre,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fitness_center, color: Colors.grey),
                        SizedBox(width: 5),
                        Text("${pokemon.weight} kg"),
                        SizedBox(width: 20),
                        Icon(Icons.height, color: Colors.grey),
                        SizedBox(width: 5),
                        Text("${pokemon.height} m"),
                      ],
                    ),
                    SizedBox(height: 12),
                    StatsPokemon(pokemon: pokemon),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: 0,
              right: 0,
              child: Center(
                child: pokemon.urlImage != ""
                    ? SvgPicture.network(
                        pokemon.urlImage,
                        height: 200,
                        width: 200,
                        placeholderBuilder: (context) =>
                            const CircularProgressIndicator(),
                      )
                    : const Icon(Icons.image_not_supported, size: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

