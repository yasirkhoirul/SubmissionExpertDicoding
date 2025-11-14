import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';

class GetTvOnAiring {
  final TvRepositories tvrepo;
  GetTvOnAiring({required this.tvrepo});
  Future<Either<Failure,List<TvseriesEntity>>> execute()async{
    return await tvrepo.getListTVonAiring();
  }
}