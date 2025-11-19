import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:equatable/equatable.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final TypeMovie? type;

  TvSeriesTable(this.id, this.title, this.posterPath, this.overview, this.type);

  factory TvSeriesTable.fromMap(Map<String, dynamic> map) {
    return TvSeriesTable(
        map['id'],
        map['title'],
        map['posterPath'],
        map['overview'],
        map['type'] == TypeMovie.Movie.toString()
            ? TypeMovie.Movie
            : TypeMovie.TvSeries);
  }

  factory TvSeriesTable.fromEntity(TvSeriesDetail tv) {
    return TvSeriesTable(
        tv.id, tv.name, tv.poster_path, tv.overview, TypeMovie.TvSeries);
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "posterPath": posterPath,
      "overview": overview,
      "type": TypeMovie.TvSeries.toString()
    };
  }

  TvseriesEntity toEntity() {
    return TvseriesEntity.watchlist(
        id: id.toDouble(),
        overview: overview,
        poster_path: posterPath,
        name: title,
        type: TypeMovie.TvSeries.toString());
  }

  @override
  List<Object?> get props => [id, overview, posterPath, title, type];
}
