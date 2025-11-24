import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tv_series_detail.dart';
import '../../repositories/tv_repositories.dart';

class RemoveWatchlistTv {
  final TvRepositories tvrepo;
  RemoveWatchlistTv({required this.tvrepo});

  Future<Either<Failure, String>> excute(TvSeriesDetail tv) {
    return tvrepo.removeWatchlist(tv);
  }
}
