import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_app/core/providers.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:riverpod/riverpod.dart';

import 'mocks/mocks.dart';


void main() {
  group('PokemonNotifier', () {
    late MockPokemonRepository mockPokemonRepository;
    late ProviderContainer container;

    setUp(() {
      mockPokemonRepository = MockPokemonRepository();
      container = ProviderContainer(overrides: [
        pokemonRepositoryProvider.overrideWithValue(mockPokemonRepository),
      ]);
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is loading', () {
      final state = container.read(pokemonNotifierProvider);
      expect(state.loading, false);
    });

    test('fetchPokemons sets state to data on success', () async {
      final pokemons = [
        const Pokemon(id: 1, name: 'Bulbasaur', url: 'url1', image: 'image1'),
        const Pokemon(id: 2, name: 'Ivysaur', url: 'url2', image: 'image2'),
      ];
      when(mockPokemonRepository.fetchPokemons(argThat(isA<int>()), argThat(isA<int>())))
          .thenAnswer((_) async => pokemons);

      await container.read(pokemonNotifierProvider.notifier).fetchPokemons(20);

      final state = container.read(pokemonNotifierProvider);
      expect(state.loading, false);
      expect(state.pokemons, pokemons);
      expect(state.error, isNull);
    });

    test('fetchPokemons sets state to error on failure', () async {
      when(mockPokemonRepository.fetchPokemons(argThat(isA<int>()), argThat(isA<int>())))
          .thenThrow(Exception('Failed to fetch pokemons'));

      await container.read(pokemonNotifierProvider.notifier).fetchPokemons(20);

      final state = container.read(pokemonNotifierProvider);
      expect(state.loading, false);
      expect(state.pokemons, isEmpty);
      expect(state.error, 'Exception: Failed to fetch pokemons');
    });
  });
}