// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
      json['count'] as int,
      json['next'] as String,
      json['previous'] as String,
      (json['results'] as List)
          ?.map((e) =>
              e == null ? null : Item.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
      json['name'] as String,
      json['height'] as String,
      json['mass'] as String,
      json['hair_color'] as String,
      json['skin_color'] as String,
      json['eye_color'] as String,
      json['birth_year'] as String,
      json['gender'] as String,
      json['homewold'] as String,
      (json['films'] as List)?.map((e) => e as String)?.toList(),
      (json['species'] as List)?.map((e) => e as String)?.toList(),
      (json['vehicles'] as List)?.map((e) => e as String)?.toList(),
      (json['starships'] as List)?.map((e) => e as String)?.toList(),
      json['created'] as String,
      json['edited'] as String,
      json['url'] as String);
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'height': instance.height,
      'mass': instance.mass,
      'hair_color': instance.hair_color,
      'skin_color': instance.skin_color,
      'eye_color': instance.eye_color,
      'birth_year': instance.birth_year,
      'gender': instance.gender,
      'homewold': instance.homewold,
      'films': instance.films,
      'species': instance.species,
      'vehicles': instance.vehicles,
      'starships': instance.starships,
      'created': instance.created,
      'edited': instance.edited,
      'url': instance.url
    };
