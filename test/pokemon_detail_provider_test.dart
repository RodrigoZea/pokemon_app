
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

    test('fetchPokemonDetail guarda el estado con la data cuando se ejecuta con éxito', () async {
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

    test('fetchPokemonDetail define el estado como error cuando no se ejecuta con éxito', () async {
      when(mockPokemonRepository.fetchPokemonDetail(argThat(isA<String>())))
          .thenThrow(Exception('Error al fetchear detalles del pokémon'));

      final futureProvider = container.read(pokemonDetailProvider('Bulbasaur').future);

      expectLater(futureProvider, throwsException);
    });
  });
}