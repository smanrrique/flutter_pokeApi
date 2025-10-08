import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_api/components/ModalDetailPokemon.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';
import 'package:poke_api/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class CardPokemon extends StatelessWidget {
  final Pokemon item;
  const CardPokemon({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = context.watch<PokemonProvider>();
    return GestureDetector(
      onTap: () => {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: "Cerrar",
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FrontModalDetailPokemon(pokemon: item);
          },
        ),
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              item.urlImage != ""
                  ? Expanded(
                      child: SvgPicture.network(
                        item.urlImage,
                        fit: BoxFit.contain,
                        placeholderBuilder: (context) =>
                            const CircularProgressIndicator(),
                      ),
                    )
                  : const Icon(Icons.image_not_supported, size: 80),
              const SizedBox(height: 10),
              Text(
                item.name,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Cerrar",
                        transitionDuration: const Duration(milliseconds: 300),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FrontModalDetailPokemon(pokemon: item);
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.lightBlue.shade50,
                      ),
                    ),
                    child: Text(
                      "Ver",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      pokemonProvider.toggleFavorite(item);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: item.isFavorite ? Colors.red : Colors.grey,
                    ),
                  )
                   
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
