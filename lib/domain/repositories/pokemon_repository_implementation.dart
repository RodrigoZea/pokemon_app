import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImplementation implements PokemonRepository {
  final GraphQLClient client;

  PokemonRepositoryImplementation(this.client);

  @override
  Future<List<Pokemon>> fetchPokemons(int limit, int offset) async {
    const String query = '''
      query Pokemons(\$limit: Int, \$offset: Int) {
        pokemons(limit: \$limit, offset: \$offset) {
          results {
            url
            name
            image
          }
        }
      }
    ''';

    final result = await client.query(QueryOptions(
      document: gql(query),
      variables: {'limit': limit, 'offset': offset},
    ));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final pokemons = (result.data?['pokemons']['results'] as List)
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final pokemonData = entry.value as Map<String, dynamic>;
          return Pokemon.fromJson({
            'id': offset + index + 1, // Calculate ID based on offset and index
            ...pokemonData,
          });
        })
        .toList();

    return pokemons;
  }
}