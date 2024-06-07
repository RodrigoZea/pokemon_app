
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_app/core/providers.dart';
import 'package:pokemon_app/domain/entities/pokemon_detail.dart';
import 'package:riverpod/riverpod.dart';

import 'mocks/mocks.dart';

void main() {
  group('PokemonDetailProvider', () {
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

    test('fetchPokemonDetail sets state to data on success', () async {
      const pokemonDetail = PokemonDetail(
        id: 1,
        name: 'Bulbasaur',
        frontDefault: 'image1',
        types: ['grass', 'poison'],
      );
      when(mockPokemonRepository.fetchPokemonDetail(argThat(isA<String>())))
          .thenAnswer((_) async => pokemonDetail);

      final state = await container.read(pokemonDetailProvider('Bulbasaur').future);
      expect(state, pokemonDetail);
    });

    test('fetchPokemonDetail sets state to error on failure', () async {
      when(mockPokemonRepository.fetchPokemonDetail(argThat(isA<String>())))
          .thenThrow(Exception('Failed to fetch pokemon details'));

      final futureProvider = container.read(pokemonDetailProvider('Bulbasaur').future);

      expectLater(futureProvider, throwsException);
    });
  });
}