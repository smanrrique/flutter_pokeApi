import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_api/components/StatsPokemon.dart';
import 'package:poke_api/components/TypePokemon.dart';
import 'package:poke_api/components/WeigthAndHeight.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';
import 'package:poke_api/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class FrontModalDetailPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const FrontModalDetailPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = context.watch<PokemonProvider>();
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
                    top: 8,
                    left: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              pokemonProvider.toggleFavorite(pokemon);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: pokemon.isFavorite
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Text(
                        pokemon.name,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      TypePokemon(pokemon: pokemon),
                      SizedBox(height: 12),
                      WeigthAndHeight(pokemon: pokemon),
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
                        height: MediaQuery.of(context).size.width * 0.4 ,
                        width: MediaQuery.of(context).size.width * 0.4 ,
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
