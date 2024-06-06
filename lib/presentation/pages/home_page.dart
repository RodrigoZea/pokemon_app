import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/state/pokemon_notifier.dart';

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
      appBar: AppBar(title: const Text('Pokemon')),
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
                    return ListTile(
                      title: Text(pokemon.name),
                    );
                  },
                ),
    );
  }
}
