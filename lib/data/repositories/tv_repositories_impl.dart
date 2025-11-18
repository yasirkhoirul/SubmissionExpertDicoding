import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tv_loacl_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_detail_recomendation.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv_series_recomendation.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';
import 'package:logger/logger.dart';


class TvRepositoriesImpl implements TvRepositories {
  TvRepositoriesImpl({required this.tvdatasource,required this.tvLoaclDataSource});
  final TvSeriesRemoteDataSource tvdatasource;
  final TvLoaclDataSource tvLoaclDataSource;
  @override
  Future<Either<Failure, List<TvseriesEntity>>> getListTVonAiring() async{
    try {
    final data = await tvdatasource.getTvSeriesOnAiring();
      return Right(data.results!.map((e) => e.toEntity(),).toList());
    } on ServerException{
      return Left(ServerFailure(""));
    } on SocketException{
      return Left(ConnectionFailure("Failed to connect network"));
    } 
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getDetail(int id) async{
    try {
      
      final data = await tvdatasource.getTvDetail(id);
      return Right(data.toEntity());
    } on ServerException{
      return Left(ServerFailure(""));
    } on SocketException{
      return Left(ConnectionFailure("Failed to connect network"));
    }
  }
  
  @override
  Future<Either<Failure, List<TvSeriesRecomendationitem>>> getRecomendation(int id) async{
    try {
      final data = await tvdatasource.getRecomendation(id);
      Logger().d("data ini adalah $data");
      return right(data.results.map((e) => e.toentity(),).toList());
    } catch (e) {
      return Left(ServerFailure(''));
    }
  }
  
  @override
  Future<Either<Failure, List<TvseriesEntity>>> getWatchlistMovies() async{
    final result = await tvLoaclDataSource.getWatchlistMovies();
    return Right(result.map((data) => data.toEntity()).toList());
  }
  
  @override
  Future<bool> isAddedToWatchlist(int id) async{
    final result = await tvLoaclDataSource.getTvById(id);
    return result != null;
  }
  
  @override
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail tv) async{
    try {
      final result =
          await tvLoaclDataSource.removeWatchlist(TvSeriesTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tv) async{
    try {
      final result =
          await tvLoaclDataSource.insertWatchlist(TvSeriesTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
  
  @override
  Future<Either<Failure, List<TvseriesEntity>>> getSearch(String data) async{
    try {
      final resulte = await tvdatasource.searchtv(data);
      return Right(resulte.results!.map((e) => e.toEntity(),).toList());
    } on ServerException{
      return Left(ServerFailure(""));
    } on SocketException{
      return Left(ConnectionFailure("Failed to connect network"));
    } 
  }
}