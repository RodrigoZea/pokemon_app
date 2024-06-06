import '../entities/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> fetchPokemons(int limit, int offset);
}