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

Map<String, dynamic> _$TvSeriesDetailRecomendationToJson(
        TvSeriesDetailRecomendation instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
    };

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

Map<String, dynamic> _$TvSeriesDetailRecomendationItemToJson(
        TvSeriesDetailRecomendationItem instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'id': instance.id,
      'name': instance.name,
      'original_language': instance.original_language,
      'original_name': instance.original_name,
      'overview': instance.overview,
      'poster_path': instance.poster_path,
      'media_type': instance.media_type,
      'genre_ids': instance.genre_ids,
      'popularity': instance.popularity,
      'first_air_date': instance.first_air_date,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
      'origin_country': instance.origin_country,
    };
