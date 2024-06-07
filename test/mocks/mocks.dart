import 'package:mockito/mockito.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/entities/pokemon_detail.dart';
import 'package:pokemon_app/domain/repositories/pokemon_repository.dart';

class MockPokemonRepository extends Mock implements PokemonRepository {
  @override
  Future<List<Pokemon>> fetchPokemons(int? limit, int? offset) =>
      super.noSuchMethod(Invocation.method(#fetchPokemons, [limit, offset]),
          returnValue: Future.value(<Pokemon>[])) as Future<List<Pokemon>>;

  @override
  Future<PokemonDetail> fetchPokemonDetail(String? name) =>
      super.noSuchMethod(Invocation.method(#fetchPokemonDetail, [name]),
          returnValue: Future.value(
              const PokemonDetail(id: 1, name: 'Bulbasaur', frontDefault: 'url', types: ['grass']))) as Future<PokemonDetail>;
}