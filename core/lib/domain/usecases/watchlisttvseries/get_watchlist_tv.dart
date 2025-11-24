import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tvseries.dart';
import '../../repositories/tv_repositories.dart';

class GetWatchlistTv {
  final TvRepositories tvrepo;
  GetWatchlistTv({required this.tvrepo});

  Future<Either<Failure, List<TvseriesEntity>>> execute() {
    return tvrepo.getWatchlistMovies();
  }
}
