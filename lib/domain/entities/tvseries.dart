import 'package:ditonton/common/state_enum.dart';
import 'package:equatable/equatable.dart';

class TvseriesEntity extends Equatable{
  bool? adult;
  String? backdrop_path;
  List<int>? genre_ids;
  double id;
  List<String>? origin_country;
  String? original_language;
  String? original_name;
  String? overview;
  double? popularity;
  String? poster_path;
  String? first_air_date;
  String? name;
  double? vote_average;
  String type;
  int? vote_count;
  TvseriesEntity(this.adult, this.backdrop_path, this.genre_ids, this.id, this.origin_country, this.original_language, this.original_name, this.overview, this.popularity, this.poster_path, this.first_air_date, this.name, this.vote_average, this.vote_count):type=TypeMovie.TvSeries.toString();
  
  TvseriesEntity.watchlist({
    required this.id,
    required this.overview,
    required this.poster_path,
    required this.name,
    required this.type
  });

  @override
  List<Object?> get props => [
    adult,
    backdrop_path,
    genre_ids,
    id,
    origin_country,
    original_language,
    original_name,
    overview,
    popularity,
    poster_path,
    first_air_date,
    name,
    vote_average,
    type
  ];
}