import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tvseries.dart';
import '../repositories/tv_repositories.dart';

class GetTvOnAiring {
  final TvRepositories tvrepo;
  GetTvOnAiring({required this.tvrepo});
  Future<Either<Failure, List<TvseriesEntity>>> execute() async {
    return await tvrepo.getListTVonAiring();
  }
}
