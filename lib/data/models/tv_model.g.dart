// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvModel _$TvModelFromJson(Map<String, dynamic> json) => TvModel(
      json['adult'] as bool,
      json['backdrop_path'] as String,
      (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['id'] as num).toDouble(),
      (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['original_language'] as String,
      json['original_name'] as String,
      json['overview'] as String,
      (json['popularity'] as num).toDouble(),
      json['poster_path'] as String,
      json['first_air_date'] as String,
      json['name'] as String,
      (json['vote_average'] as num).toDouble(),
      (json['vote_count'] as num).toInt(),
    );

Map<String, dynamic> _$TvModelToJson(TvModel instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'genre_ids': instance.genre_ids,
      'id': instance.id,
      'origin_country': instance.origin_country,
      'original_language': instance.original_language,
      'original_name': instance.original_name,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'first_air_date': instance.first_air_date,
      'name': instance.name,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };
