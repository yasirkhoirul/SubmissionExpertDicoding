import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tv_series_detail.dart';
import '../repositories/tv_repositories.dart';

class GetTvSeriesDetail {
  GetTvSeriesDetail(this.tvrepo);
  final TvRepositories tvrepo;

  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return tvrepo.getDetail(id);
  }
}
