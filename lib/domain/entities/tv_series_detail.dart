import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  final int id;
  final String name;
  final String poster_path;
  final String overview;
  final double rating;
  final int reviewer;
  final int episode;
  final int season;

  TvSeriesDetail(
      {required this.name,
      required this.poster_path,
      required this.overview,
      required this.rating,
      required this.reviewer,
      required this.episode,
      required this.season,
      required this.id});

  @override
  List<Object?> get props =>
      [name, poster_path, overview, rating, reviewer, episode, season, id];
}
