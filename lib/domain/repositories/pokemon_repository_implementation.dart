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
            name
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
        .map((e) => Pokemon.fromJson(e))
        .toList();

    return pokemons;
  }
}