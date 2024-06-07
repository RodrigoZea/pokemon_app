import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_detail.freezed.dart';
part 'pokemon_detail.g.dart';

@freezed
class PokemonDetail with _$PokemonDetail {
  const factory PokemonDetail({
    required int id,
    required String name,
    required String frontDefault,
    required List<String> types,
  }) = _PokemonDetail;

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => _$PokemonDetailFromJson(json);
}