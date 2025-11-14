import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tvseries.dart';

abstract class TvRepositories {
  Future<Either<Failure,List<TvseriesEntity>>> getListTVonAiring();
}