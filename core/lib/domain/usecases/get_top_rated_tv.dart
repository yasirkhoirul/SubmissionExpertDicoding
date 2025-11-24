import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tvseries.dart';
import '../repositories/tv_repositories.dart';
import 'package:logger/web.dart';

class GetTopRatedTv {
  final TvRepositories tvrepo;
  GetTopRatedTv(this.tvrepo);

  Future<Either<Failure, List<TvseriesEntity>>> execute() async {
    Logger().d("masuk use cse top rated");
    return await tvrepo.getTopratedTv();
  }
}
