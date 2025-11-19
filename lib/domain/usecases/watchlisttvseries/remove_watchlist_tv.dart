import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';

class RemoveWatchlistTv {
  final TvRepositories tvrepo;
  RemoveWatchlistTv({required this.tvrepo});

  Future<Either<Failure, String>> excute(TvSeriesDetail tv) {
    return tvrepo.removeWatchlist(tv);
  }
}
