import 'package:equatable/equatable.dart';
import 'package:pokemon_app/domain/repositories/pokemon_repository.dart';
import 'package:riverpod/riverpod.dart';
import '../../domain/entities/pokemon.dart';
import '../providers.dart';

// Usamos equatable para evitar renderizaciones innecesarias, ya que el estado solo se actualizará cuando cambien los valores
// También se podría realizar utilizando @freezed, pero preferí implementarlo de esta forma para usar Equatable y optimizar rendimiento
class PokemonState extends Equatable {
  final List<Pokemon> pokemons;
  final bool loading;
  final String? error;
  final int offset;

  const PokemonState({
    this.pokemons = const [],
    this.loading = false,
    this.error,
    this.offset = 0,
  });

  PokemonState copyWith({
    List<Pokemon>? pokemons,
    bool? loading,
    String? error,
    int? offset,
  }) {
    return PokemonState(
      pokemons: pokemons ?? this.pokemons,
      loading: loading ?? this.loading,
      error: error,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props => [pokemons, loading, error, offset];
}

// Debido a que se pidió utiliazr StateNotifier, la implementación se estará haciendo de esta manera.
// Sin embargo, StateNotifier ha sido reemplazado (no está obsoleto) en Riverpod 2.0 a favor de Notifier/AsyncNotifier.
class PokemonNotifier extends StateNotifier<PokemonState> {
  final PokemonRepository repository;

  PokemonNotifier(this.repository) : super(const PokemonState()) {
    fetchPokemons(20);
  }

  Future<void> fetchPokemons(int limit) async {
    // solo queremos realizar un fetch al cargar, evitamos varios de esta manera
    if (state.loading) return; 

    try {
      final pokemons = await repository.fetchPokemons(limit, state.offset);
      state = state.copyWith(
        pokemons: List.from(state.pokemons)..addAll(pokemons),
        loading: false,
        offset: state.offset + limit
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), loading: false);
    }
  }
}

final pokemonNotifierProvider =
    StateNotifierProvider<PokemonNotifier, PokemonState>((ref) {
      final repository = ref.watch(pokemonRepositoryProvider);
      return PokemonNotifier(repository);
    });