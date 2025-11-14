import 'package:equatable/equatable.dart';

class TvseriesEntity extends Equatable{
  final bool adult;
  final String backdrop_path;
  final List<int> genre_ids;
  final double id;
  final List<String> origin_country;
  final String original_language;
  final String original_name;
  final String overview;
  final double popularity;
  final String poster_path;
  final String first_air_date;
  final String name;
  final double vote_average;
  final int vote_count;
  TvseriesEntity(this.adult, this.backdrop_path, this.genre_ids, this.id, this.origin_country, this.original_language, this.original_name, this.overview, this.popularity, this.poster_path, this.first_air_date, this.name, this.vote_average, this.vote_count);
  
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
    vote_average
  ];
}