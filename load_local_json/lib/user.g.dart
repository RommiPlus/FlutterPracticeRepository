// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['name'] as String,
      json['height'] as String,
      json['mass'] as String,
      json['hair_color'] as String,
      json['skin_color'] as String,
      json['eye_color'] as String,
      json['birth_year'] as String,
      json['gender'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'height': instance.height,
      'mass': instance.mass,
      'hair_color': instance.hair_color,
      'skin_color': instance.skin_color,
      'eye_color': instance.eye_color,
      'birth_year': instance.birth_year,
      'gender': instance.gender
    };
