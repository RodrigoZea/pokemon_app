import 'package:flutter/material.dart';
import 'package:pokemon_app/core/state/pokemon_notifier.dart';
import 'package:riverpod/riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokemon_app/domain/repositories/pokemon_repository_implementation.dart';
import '../domain/repositories/pokemon_repository.dart';

final clientProvider = Provider<ValueNotifier<GraphQLClient>>((ref) {
  // esto igual será reemplazado por la definición en el main. 
  // en caso no configuremos nuestro cliente, se retornará este error.
  throw UnimplementedError(); 
});

final graphQLClientProvider = Provider<GraphQLClient>((ref) {
  final client = ref.watch(clientProvider);
  return client.value;
});

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  final client = ref.watch(graphQLClientProvider);
  return PokemonRepositoryImplementation(client);
});

final pokemonNotifierProvider = StateNotifierProvider<PokemonNotifier, PokemonState>((ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return PokemonNotifier(repository);
});