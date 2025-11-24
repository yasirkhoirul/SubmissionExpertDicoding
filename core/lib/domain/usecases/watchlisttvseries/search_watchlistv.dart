import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tvseries.dart';
import '../../repositories/tv_repositories.dart';

class SearchWatchlistTv {
  final TvRepositories tvrepo;
  SearchWatchlistTv({required this.tvrepo});

  Future<Either<Failure, List<TvseriesEntity>>> excute(String data) {
    return tvrepo.getSearch(data);
  }
}
