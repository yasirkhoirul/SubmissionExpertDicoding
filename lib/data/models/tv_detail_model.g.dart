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

Map<String, dynamic> _$TvDetailModelToJson(TvDetailModel instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'created_by': instance.created_by,
      'episode_run_time': instance.episode_run_time,
      'first_air_date': instance.first_air_date,
      'genres': instance.genres,
      'homepage': instance.homepage,
      'id': instance.id,
      'in_production': instance.in_production,
      'languages': instance.languages,
      'last_air_date': instance.last_air_date,
      'last_episode_to_air': instance.last_episode_to_air,
      'name': instance.name,
      'next_episode_to_air': instance.next_episode_to_air,
      'networks': instance.networks,
      'number_of_episodes': instance.number_of_episodes,
      'number_of_seasons': instance.number_of_seasons,
      'origin_country': instance.origin_country,
      'original_language': instance.original_language,
      'original_name': instance.original_name,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.poster_path,
      'production_companies': instance.production_companies,
      'production_countries': instance.production_countries,
      'seasons': instance.seasons,
      'spoken_languages': instance.spoken_languages,
      'status': instance.status,
      'tagline': instance.tagline,
      'type': instance.type,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      (json['id'] as num).toInt(),
      json['credit_id'] as String,
      json['name'] as String,
      json['original_name'] as String,
      (json['gender'] as num).toInt(),
      json['profile_path'] as String?,
    );

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      'id': instance.id,
      'credit_id': instance.credit_id,
      'name': instance.name,
      'original_name': instance.original_name,
      'gender': instance.gender,
      'profile_path': instance.profile_path,
    };

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

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
      'air_date': instance.air_date,
      'episode_number': instance.episode_number,
      'episode_type': instance.episode_type,
      'production_code': instance.production_code,
      'runtime': instance.runtime,
      'season_number': instance.season_number,
      'show_id': instance.show_id,
      'still_path': instance.still_path,
    };

Network _$NetworkFromJson(Map<String, dynamic> json) => Network(
      (json['id'] as num).toInt(),
      json['logo_path'] as String?,
      json['name'] as String,
      json['origin_country'] as String,
    );

Map<String, dynamic> _$NetworkToJson(Network instance) => <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logo_path,
      'name': instance.name,
      'origin_country': instance.origin_country,
    };

Production_companies _$Production_companiesFromJson(
        Map<String, dynamic> json) =>
    Production_companies(
      (json['id'] as num).toInt(),
      json['logo_path'] as String?,
      json['name'] as String,
      json['origin_country'] as String,
    );

Map<String, dynamic> _$Production_companiesToJson(
        Production_companies instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logo_path,
      'name': instance.name,
      'origin_country': instance.origin_country,
    };

Production_countries _$Production_countriesFromJson(
        Map<String, dynamic> json) =>
    Production_countries(
      json['iso_3166_1'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$Production_countriesToJson(
        Production_countries instance) =>
    <String, dynamic>{
      'iso_3166_1': instance.iso_3166_1,
      'name': instance.name,
    };

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

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'air_date': instance.air_date,
      'episode_count': instance.episode_count,
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'poster_path': instance.poster_path,
      'season_number': instance.season_number,
      'vote_average': instance.vote_average,
    };

Spoken_languages _$Spoken_languagesFromJson(Map<String, dynamic> json) =>
    Spoken_languages(
      json['english_name'] as String,
      json['iso_639_1'] as String,
      json['name'] as String,
    );

Map<String, dynamic> _$Spoken_languagesToJson(Spoken_languages instance) =>
    <String, dynamic>{
      'english_name': instance.english_name,
      'iso_639_1': instance.iso_639_1,
      'name': instance.name,
    };
