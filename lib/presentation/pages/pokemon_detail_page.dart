import 'package:flutter/material.dart';

class PokemonDetailPage extends StatelessWidget {
  final String name;

  const PokemonDetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    // Fetch and display detailed information about the Pokémon using the `url`
    return Scaffold(
      appBar: AppBar(title: const Text('Pokemon Detail')),
      body: Center(
        child: Text('Details for Pokemon with name: $name'),
      ),
    );
  }
}
