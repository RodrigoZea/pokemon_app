import '../entities/pokemon.dart';
import '../entities/pokemon_detail.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> fetchPokemons(int limit, int offset);
  Future<PokemonDetail> fetchPokemonDetail(String name);
}