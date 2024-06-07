import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_app/extensions/utils.dart';

import '../../core/providers.dart';

class PokemonDetailPage extends ConsumerWidget {
  final String name;

  const PokemonDetailPage({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonDetailAsyncValue = ref.watch(pokemonDetailProvider(name));

    return Scaffold(
      appBar: AppBar(title: 
        Text(
          'Detalles',
          style: GoogleFonts.pixelifySans(
            textStyle: const TextStyle(
              fontSize: 30
            )
          )
        )      
      ),
      body: pokemonDetailAsyncValue.when(
        data: (pokemonDetail) {
          
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  pokemonDetail.frontDefault,
                  scale: 0.6,
                ),
                Text(
                  pokemonDetail.name.capitalize(), 
                  style: GoogleFonts.vt323( 
                    textStyle: const TextStyle(
                      fontSize: 35
                    )
                  )
                ),
                const SizedBox(height: 10),
                Text(
                  'Tipo(s):', 
                  style: GoogleFonts.pixelifySans(
                    textStyle: const TextStyle(
                      fontSize: 24
                    )
                  )
                  )
                ,
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  children: pokemonDetail.types.map((type) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.yellow),
                      ),
                      child: Text(
                        type.capitalize(),
                        style: GoogleFonts.vt323(
                          textStyle: const TextStyle(
                            fontSize: 24
                          )
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
          )
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(backgroundColor: Colors.blue, color: Colors.blueGrey)),
        error: (e, stack) => 
        Center(child: 
          Text(
            '''
            ¡Pokémon no encontrado! ${'\n'}
            Error: ${e.toString()}
            ''',
            style: GoogleFonts.pixelifySans(
              textStyle: const TextStyle(
                fontSize: 30,
                height: 0.5
              )
            ),
            textAlign: TextAlign.center,
          )  
        ),
      ),
    );
  }
}