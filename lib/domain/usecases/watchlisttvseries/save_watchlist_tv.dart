import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';

class SaveWatchlistTv {
  final TvRepositories tvrepo;
  SaveWatchlistTv({required this.tvrepo});

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    return tvrepo.saveWatchlist(tv);
  }
}
