// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JokeModelImpl _$$JokeModelImplFromJson(Map<String, dynamic> json) =>
    _$JokeModelImpl(
      id: (json['id'] as num).toInt(),
      setup: json['setup'] as String,
      punchline: json['punchline'] as String,
      category: json['type'] as String,
    );

Map<String, dynamic> _$$JokeModelImplToJson(_$JokeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'setup': instance.setup,
      'punchline': instance.punchline,
      'type': instance.category,
    };
