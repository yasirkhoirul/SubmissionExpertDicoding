// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvModel _$TvModelFromJson(Map<String, dynamic> json) => TvModel(
      json['adult'] as bool,
      json['backdrop_path'] as String?,
      (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['id'] as num).toDouble(),
      (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['original_language'] as String?,
      json['original_name'] as String?,
      json['overview'] as String?,
      (json['popularity'] as num?)?.toDouble(),
      json['poster_path'] as String?,
      json['first_air_date'] as String?,
      json['name'] as String?,
      (json['vote_average'] as num?)?.toDouble(),
      (json['vote_count'] as num?)?.toInt(),
    );

