import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv_series_recomendation.dart';
import 'package:ditonton/domain/entities/tvseries.dart';

abstract class TvRepositories {
  Future<Either<Failure,List<TvseriesEntity>>> getListTVonAiring();
  Future<Either<Failure,TvSeriesDetail>> getDetail(int id);
  Future<Either<Failure,List<TvSeriesRecomendationitem>>> getRecomendation(int id);
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvseriesEntity>>> getWatchlistMovies();
  Future<Either<Failure, List<TvseriesEntity>>> getSearch(String data);
}