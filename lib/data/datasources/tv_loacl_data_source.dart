import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:logger/logger.dart';

abstract class TvLoaclDataSource {
  Future<String> insertWatchlist(TvSeriesTable tv);
  Future<String> removeWatchlist(TvSeriesTable tv);
  Future<TvSeriesTable?> getTvById(int id);
  Future<List<TvSeriesTable>> getWatchlistMovies();
}

class TvLoaclDataSourceImpl implements TvLoaclDataSource {
  final DatabaseHelper databaseHelper;
  TvLoaclDataSourceImpl({required this.databaseHelper});
  @override
  Future<TvSeriesTable?> getTvById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TvSeriesTable tv) async {
    try {
      Logger().d("add di insert adalah $tv");
      await databaseHelper.insertWatchlisttv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable tv) async {
    try {
      await databaseHelper.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
