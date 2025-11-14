import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';

class TvRepositoriesImpl implements TvRepositories {
  TvRepositoriesImpl({required this.tvdatasource});
  final TvSeriesRemoteDataSource tvdatasource;
  @override
  Future<Either<Failure, List<TvseriesEntity>>> getListTVonAiring() async{
    try {
    final data = await tvdatasource.getTvSeriesOnAiring();
      return Right(data.result!.map((e) => e.toEntity(),).toList());
    } on ServerException{
      throw Left(ServerFailure(""));
    } on SocketException{
      throw Left(ConnectionFailure("Failed to connect network"));
    } 
  }
}