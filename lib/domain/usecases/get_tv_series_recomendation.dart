import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_recomendation.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';

class GetTvSeriesRecomendation {
  final TvRepositories repo;
  GetTvSeriesRecomendation(this.repo);

  Future<Either<Failure, List<TvSeriesRecomendationitem>>> execute(
      int id) async {
    return repo.getRecomendation(id);
  }
}
