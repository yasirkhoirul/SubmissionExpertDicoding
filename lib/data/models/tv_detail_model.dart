import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_detail_model.g.dart';

@JsonSerializable()
class TvDetailModel extends Equatable {
  final bool adult;
  final String backdrop_path;
  final List<CreatedBy> created_by;
  final List? episode_run_time;
  final String first_air_date;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool in_production;
  final List<String> languages;
  final String last_air_date;
  final Episode? last_episode_to_air;
  final String name;
  final Episode? next_episode_to_air;
  final List<Network> networks;
  final int number_of_episodes;
  final int number_of_seasons;
  final List<String> origin_country;
  final String original_language;
  final String original_name;
  final String overview;
  final double popularity;
  final String poster_path;
  final List<Production_companies> production_companies;
  final List<Production_countries> production_countries;
  final List<Season> seasons;
  final List<Spoken_languages> spoken_languages;
  final String status;
  final String tagline;
  final String type;
  final double vote_average;
  final int vote_count;
  TvDetailModel(
      this.adult,
      this.backdrop_path,
      this.created_by,
      this.episode_run_time,
      this.first_air_date,
      this.genres,
      this.homepage,
      this.id,
      this.in_production,
      this.languages,
      this.last_air_date,
      this.last_episode_to_air,
      this.name,
      this.next_episode_to_air,
      this.networks,
      this.number_of_episodes,
      this.number_of_seasons,
      this.origin_country,
      this.original_language,
      this.original_name,
      this.overview,
      this.popularity,
      this.poster_path,
      this.production_companies,
      this.production_countries,
      this.seasons,
      this.spoken_languages,
      this.status,
      this.tagline,
      this.type,
      this.vote_average,
      this.vote_count);
  factory TvDetailModel.fromJson(Map<String, dynamic> json) =>
      _$TvDetailModelFromJson(json);

  @override
  List<Object?> get props => [
        adult,
        backdrop_path,
        created_by,
        episode_run_time,
        first_air_date,
        genres,
        homepage,
        id,
        in_production,
        languages,
        last_air_date,
        last_episode_to_air,
        name,
        next_episode_to_air,
        networks,
        number_of_episodes,
        number_of_seasons,
        origin_country,
        original_language,
        original_name,
        overview,
        popularity,
        poster_path,
        production_companies,
        production_countries,
        seasons,
        spoken_languages,
        status,
        tagline,
        type,
        vote_average,
        vote_count,
      ];

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
        id: id,
        name: name,
        poster_path: poster_path,
        overview: overview,
        rating: vote_average,
        reviewer: vote_count,
        episode: number_of_episodes,
        season: number_of_seasons);
  }
}

@JsonSerializable()
class CreatedBy extends Equatable {
  final int id;
  final String credit_id;
  final String name;
  final String original_name;
  final int gender;
  final String? profile_path;
  CreatedBy(this.id, this.credit_id, this.name, this.original_name, this.gender,
      this.profile_path);

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);

  @override
  List<Object?> get props =>
      [id, credit_id, name, original_name, gender, profile_path];
}

@JsonSerializable()
class Episode extends Equatable {
  final int id;
  final String name;
  final String overview;
  final double vote_average;
  final int vote_count;
  final String? air_date;
  final int episode_number;
  final String episode_type;
  final String production_code;
  final int? runtime;
  final int season_number;
  final int show_id;
  final String? still_path;
  Episode(
      this.id,
      this.name,
      this.overview,
      this.vote_average,
      this.vote_count,
      this.air_date,
      this.episode_number,
      this.episode_type,
      this.production_code,
      this.runtime,
      this.season_number,
      this.show_id,
      this.still_path);
  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        vote_average,
        vote_count,
        air_date,
        episode_number,
        episode_type,
        production_code,
        runtime,
        season_number,
        show_id,
        still_path
      ];
}

@JsonSerializable()
class Network extends Equatable {
  final int id;
  final String? logo_path;
  final String name;
  final String origin_country;
  Network(this.id, this.logo_path, this.name, this.origin_country);
  factory Network.fromJson(Map<String, dynamic> json) =>
      _$NetworkFromJson(json);
  @override
  List<Object?> get props => [id, logo_path, name, origin_country];
}

@JsonSerializable()
class Production_companies extends Equatable {
  final int id;
  final String? logo_path;
  final String name;
  final String origin_country;
  Production_companies(this.id, this.logo_path, this.name, this.origin_country);
  factory Production_companies.fromJson(Map<String, dynamic> json) =>
      _$Production_companiesFromJson(json);

  @override
  List<Object?> get props => [id, logo_path, name, origin_country];
}

@JsonSerializable()
class Production_countries extends Equatable {
  final String iso_3166_1;
  final String name;
  Production_countries(this.iso_3166_1, this.name);
  factory Production_countries.fromJson(Map<String, dynamic> json) =>
      _$Production_countriesFromJson(json);
  @override
  List<Object?> get props => [iso_3166_1, name];
}

@JsonSerializable()
class Season extends Equatable {
  final String? air_date;
  final int episode_count;
  final int id;
  final String name;
  final String overview;
  final String? poster_path;
  final int season_number;
  final double vote_average;
  Season(this.air_date, this.episode_count, this.id, this.name, this.overview,
      this.poster_path, this.season_number, this.vote_average);
  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  @override
  List<Object?> get props => [
        air_date,
        episode_count,
        id,
        name,
        overview,
        poster_path,
        season_number,
        vote_average
      ];
}

@JsonSerializable()
class Spoken_languages extends Equatable {
  final String english_name;
  final String iso_639_1;
  final String name;
  Spoken_languages(this.english_name, this.iso_639_1, this.name);
  factory Spoken_languages.fromJson(Map<String, dynamic> json) =>
      _$Spoken_languagesFromJson(json);

  @override
  List<Object?> get props => [english_name, iso_639_1, name];
}
