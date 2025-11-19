import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';
import 'package:logger/web.dart';

class GetTopRatedTv {
  final TvRepositories tvrepo;
  GetTopRatedTv(this.tvrepo);

  Future<Either<Failure, List<TvseriesEntity>>> execute() async {
    Logger().d("masuk use cse top rated");
    return await tvrepo.getTopratedTv();
  }
}
