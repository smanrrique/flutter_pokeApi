import 'package:flutter/material.dart';
import 'package:poke_api/data/model/pokemon_datail_response.dart';

class CardPokemon extends StatelessWidget {

  final Pokemon item; 
  const CardPokemon({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          item.urlImage != null
              ? Image.network(
                  item.urlImage!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )
              : const Icon(Icons.image_not_supported, size: 80),
          const SizedBox(height: 5),
          Text(item.name),
        ],
      ),
    );;
  }
}