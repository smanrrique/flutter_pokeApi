import 'package:flutter/material.dart';

class TextfieldSearch extends StatelessWidget {
  const TextfieldSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintText: "Search a Pokemon",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (text) {},
    );
  }
}
