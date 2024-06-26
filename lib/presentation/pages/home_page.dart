import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_app/extensions/utils.dart';
import '../../core/state/pokemon_notifier.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(pokemonNotifierProvider.notifier).fetchPokemons(20);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pokemonNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: 
            Text(
              'Pokédex',
              style: GoogleFonts.pixelifySans(
                textStyle: const TextStyle(
                  fontSize: 30
                )
              )
            )      
      ),
      body: state.loading && state.pokemons.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: state.pokemons.length + (state.loading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.pokemons.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final pokemon = state.pokemons[index];
                    return Center(
                      child: SizedBox(
                        width: 300, // Adjust the width as needed
                        child: InkWell(
                          onTap: () {
                            context.goNamed('detail', pathParameters: {'name': pokemon.name});
                          },
                          child: Card(

                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '#${pokemon.id}',
                                        style: GoogleFonts.vt323(
                                          textStyle: const TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold
                                          )
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Image.network(
                                        pokemon.image,
                                        width: 80,
                                        height: 80,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(Icons.error);
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    pokemon.name.capitalize(),
                                    style: GoogleFonts.vt323(
                                      textStyle: const TextStyle(
                                        fontSize: 25.0
                                      )
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
