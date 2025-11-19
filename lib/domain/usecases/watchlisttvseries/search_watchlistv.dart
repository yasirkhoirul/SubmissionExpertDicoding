import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';

class SearchWatchlistTv {
  final TvRepositories tvrepo;
  SearchWatchlistTv({required this.tvrepo});

  Future<Either<Failure, List<TvseriesEntity>>> excute(String data) {
    return tvrepo.getSearch(data);
  }
}
