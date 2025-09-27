import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';

class ModalDetailPokemon extends StatelessWidget {
  final Pokemon pokemon;

  const ModalDetailPokemon({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width:
              MediaQuery.of(context).size.width *
              0.6, // ancho 80% de la pantalla
          height: MediaQuery.of(context).size.height *
              0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                pokemon.urlImage != null
                    ? SvgPicture.network(
                        pokemon.urlImage!,
                        height: 100,
                        width: 100,
                        placeholderBuilder: (context) =>
                            const CircularProgressIndicator(),
                      )
                    : const Icon(Icons.image_not_supported, size: 80),
                const SizedBox(height: 10),
                Text(
                  pokemon.name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
