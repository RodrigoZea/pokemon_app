import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemon_app/domain/entities/pokemon.dart';
import 'package:pokemon_app/domain/entities/pokemon_detail.dart';
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

  @override
  Future<PokemonDetail> fetchPokemonDetail(String name) async {
    const String query = '''
      query Pokemon(\$name: String!) {
        pokemon(name: \$name) {
          id
          name
          sprites {
            front_default
          }
          types {
            type {
              name
            }
          }
        }
      }
    ''';

    final result = await client.query(QueryOptions(
      document: gql(query),
      variables: {'name' : name},
    ));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final pokemonData = result.data?['pokemon'];
    if (pokemonData == null) {
      throw Exception('Pokemon not found');
    }

    final types = (pokemonData['types'] as List)
        .map((type) => type['type']['name'] as String)
        .toList();

    return PokemonDetail.fromJson({
      'id': pokemonData['id'],
      'name': pokemonData['name'],
      'frontDefault': pokemonData['sprites']['front_default'],
      'types': types,
    });

  }
}