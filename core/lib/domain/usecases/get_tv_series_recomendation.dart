import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tv_series_recomendation.dart';
import '../repositories/tv_repositories.dart';

class GetTvSeriesRecomendation {
  final TvRepositories repo;
  GetTvSeriesRecomendation(this.repo);

  Future<Either<Failure, List<TvSeriesRecomendationitem>>> execute(
      int id) async {
    return repo.getRecomendation(id);
  }
}
