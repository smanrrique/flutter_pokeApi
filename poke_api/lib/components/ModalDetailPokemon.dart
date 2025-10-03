import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_api/components/StatsPokemon.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';
import 'package:poke_api/utils/app_colors.dart';

class FrontModalDetailPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const FrontModalDetailPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 200,
                maxWidth: MediaQuery.of(context).size.width * 0.7,
                minHeight: 150,
                maxHeight: MediaQuery.of(context).size.height * 0.55,
              ),
              child: Container(
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
                          fontSize: MediaQuery.of(context).size.width * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: pokemon.listTypes.map((nombre) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              bottom: 0,
                              left: 8,
                              right: 8,
                            ),
                            child: Container(
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
                                child: Center(
                                  child: Text(
                                    nombre,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                          0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                      ),
                      SizedBox(height: 12),
                      StatsPokemon(pokemon: pokemon),
                    ],
                  ),
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
