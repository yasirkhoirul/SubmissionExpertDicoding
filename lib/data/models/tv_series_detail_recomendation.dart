
import 'package:ditonton/domain/entities/tv_series_recomendation.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_series_detail_recomendation.g.dart';

@JsonSerializable()
class TvSeriesDetailRecomendation extends Equatable {
  final int page;
  final List<TvSeriesDetailRecomendationItem> results;
  TvSeriesDetailRecomendation(this.page, this.results);
  
  factory TvSeriesDetailRecomendation.fromJson(Map<String,dynamic> json) => _$TvSeriesDetailRecomendationFromJson(json);

  
  @override
  List<Object?> get props => [
    page,
    results
  ];
}

@JsonSerializable()
class TvSeriesDetailRecomendationItem extends Equatable {
  final bool adult;
  final String? backdrop_path;
  final int id;
  final String? name;
  final String? original_language;
  final String? original_name;
  final String? overview;
  final String? poster_path;
  final String? media_type;
  final List<int>? genre_ids;
  final double? popularity;
  final String first_air_date;
  final double vote_average;
  final int vote_count;
  final List<String> origin_country;
  TvSeriesDetailRecomendationItem(
      this.adult,
      this.backdrop_path,
      this.id,
      this.name,
      this.original_language,
      this.original_name,
      this.overview,
      this.poster_path,
      this.media_type,
      this.genre_ids,
      this.popularity,
      this.first_air_date,
      this.vote_average,
      this.vote_count,
      this.origin_country);

  factory TvSeriesDetailRecomendationItem.fromJson(Map<String,dynamic> json) => _$TvSeriesDetailRecomendationItemFromJson(json);

  TvSeriesRecomendationitem toentity(){
    return TvSeriesRecomendationitem(path: poster_path??'', id: id);
  }
  @override
  List<Object?> get props => [
        adult,
        backdrop_path,
        id,
        name,
        original_language,
        original_name,
        overview,
        poster_path,
        media_type,
        genre_ids,
        popularity,
        first_air_date,
        vote_average,
        vote_count,
        origin_country
      ];
}
