import 'package:dartz/dartz.dart';
import '../../../utils/failure.dart';
import '../../entities/tv_series_detail.dart';
import '../../repositories/tv_repositories.dart';

class SaveWatchlistTv {
  final TvRepositories tvrepo;
  SaveWatchlistTv({required this.tvrepo});

  Future<Either<Failure, String>> execute(TvSeriesDetail tv) {
    return tvrepo.saveWatchlist(tv);
  }
}
