// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvDetailModel _$TvDetailModelFromJson(Map<String, dynamic> json) =>
    TvDetailModel(
      json['adult'] as bool,
      json['backdrop_path'] as String,
      (json['created_by'] as List<dynamic>)
          .map((e) => CreatedBy.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['episode_run_time'] as List<dynamic>?,
      json['first_air_date'] as String,
      (json['genres'] as List<dynamic>)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['homepage'] as String,
      (json['id'] as num).toInt(),
      json['in_production'] as bool,
      (json['languages'] as List<dynamic>).map((e) => e as String).toList(),
      json['last_air_date'] as String,
      json['last_episode_to_air'] == null
          ? null
          : Episode.fromJson(
              json['last_episode_to_air'] as Map<String, dynamic>),
      json['name'] as String,
      json['next_episode_to_air'] == null
          ? null
          : Episode.fromJson(
              json['next_episode_to_air'] as Map<String, dynamic>),
      (json['networks'] as List<dynamic>)
          .map((e) => Network.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['number_of_episodes'] as num).toInt(),
      (json['number_of_seasons'] as num).toInt(),
      (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      json['original_language'] as String,
      json['original_name'] as String,
      json['overview'] as String,
      (json['popularity'] as num).toDouble(),
      json['poster_path'] as String,
      (json['production_companies'] as List<dynamic>)
          .map((e) => Production_companies.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['production_countries'] as List<dynamic>)
          .map((e) => Production_countries.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['seasons'] as List<dynamic>)
          .map((e) => Season.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['spoken_languages'] as List<dynamic>)
          .map((e) => Spoken_languages.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as String,
      json['tagline'] as String,
      json['type'] as String,
      (json['vote_average'] as num).toDouble(),
      (json['vote_count'] as num).toInt(),
    );

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      (json['id'] as num).toInt(),
      json['credit_id'] as String,
      json['name'] as String,
      json['original_name'] as String,
      (json['gender'] as num).toInt(),
      json['profile_path'] as String?,
    );



Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['overview'] as String,
      (json['vote_average'] as num).toDouble(),
      (json['vote_count'] as num).toInt(),
      json['air_date'] as String?,
      (json['episode_number'] as num).toInt(),
      json['episode_type'] as String,
      json['production_code'] as String,
      (json['runtime'] as num?)?.toInt(),
      (json['season_number'] as num).toInt(),
      (json['show_id'] as num).toInt(),
      json['still_path'] as String?,
    );



Network _$NetworkFromJson(Map<String, dynamic> json) => Network(
      (json['id'] as num).toInt(),
      json['logo_path'] as String?,
      json['name'] as String,
      json['origin_country'] as String,
    );


Production_companies _$Production_companiesFromJson(
        Map<String, dynamic> json) =>
    Production_companies(
      (json['id'] as num).toInt(),
      json['logo_path'] as String?,
      json['name'] as String,
      json['origin_country'] as String,
    );

Production_countries _$Production_countriesFromJson(
        Map<String, dynamic> json) =>
    Production_countries(
      json['iso_3166_1'] as String,
      json['name'] as String,
    );

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      json['air_date'] as String?,
      (json['episode_count'] as num).toInt(),
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['overview'] as String,
      json['poster_path'] as String?,
      (json['season_number'] as num).toInt(),
      (json['vote_average'] as num).toDouble(),
    );


Spoken_languages _$Spoken_languagesFromJson(Map<String, dynamic> json) =>
    Spoken_languages(
      json['english_name'] as String,
      json['iso_639_1'] as String,
      json['name'] as String,
    );