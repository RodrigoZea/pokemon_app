// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonDetailImpl _$$PokemonDetailImplFromJson(Map<String, dynamic> json) =>
    _$PokemonDetailImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      frontDefault: json['frontDefault'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PokemonDetailImplToJson(_$PokemonDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'frontDefault': instance.frontDefault,
      'types': instance.types,
    };
