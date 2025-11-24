import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tvseries.dart';
import '../repositories/tv_repositories.dart';

class GetPopularTv {
  final TvRepositories tvrepo;
  GetPopularTv(this.tvrepo);

  Future<Either<Failure, List<TvseriesEntity>>> execute() async {
    return await tvrepo.getPopularTv();
  }
}
