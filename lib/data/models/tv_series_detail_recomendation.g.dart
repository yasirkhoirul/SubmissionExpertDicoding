// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series_detail_recomendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvSeriesDetailRecomendation _$TvSeriesDetailRecomendationFromJson(
        Map<String, dynamic> json) =>
    TvSeriesDetailRecomendation(
      (json['page'] as num).toInt(),
      (json['results'] as List<dynamic>)
          .map((e) => TvSeriesDetailRecomendationItem.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );


TvSeriesDetailRecomendationItem _$TvSeriesDetailRecomendationItemFromJson(
        Map<String, dynamic> json) =>
    TvSeriesDetailRecomendationItem(
      json['adult'] as bool,
      json['backdrop_path'] as String?,
      (json['id'] as num).toInt(),
      json['name'] as String?,
      json['original_language'] as String?,
      json['original_name'] as String?,
      json['overview'] as String?,
      json['poster_path'] as String?,
      json['media_type'] as String?,
      (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      (json['popularity'] as num?)?.toDouble(),
      json['first_air_date'] as String,
      (json['vote_average'] as num).toDouble(),
      (json['vote_count'] as num).toInt(),
      (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );