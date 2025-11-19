import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_series_detail_recomendation.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:ditonton/data/repositories/tv_repositories_impl.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpertvseries.mocks.dart';
import '../../json_reader.dart';

void main() {
  late MockTvLoaclDataSource mockTvLoaclDataSource;
  late MockTvSeriesRemoteDataSource mockdatasource;
  late TvRepositoriesImpl tvRepositories;
  setUp(() {
    mockTvLoaclDataSource = MockTvLoaclDataSource();
    mockdatasource = MockTvSeriesRemoteDataSource();
    tvRepositories = TvRepositoriesImpl(
        tvdatasource: mockdatasource, tvLoaclDataSource: mockTvLoaclDataSource);
  });

  test('getLIst should return list movie', () async {
    //arrange
    final fakeEntity = listTvEntity;
    when(mockdatasource.getTvSeriesOnAiring()).thenAnswer(
      (realInvocation) async => dummyResonse,
    );

    //act
    final result = await tvRepositories.getListTVonAiring();

    //assert
    verify(mockdatasource.getTvSeriesOnAiring()).called(1);
    final resultlist = result.getOrElse(
      () => [],
    );
    expect(resultlist, fakeEntity);
  });

  group("get popular test", () {
    test('getLIst should return list tv popular', () async {
      //arrange
      final fakeEntity = listTvEntity;
      when(mockdatasource.getPopular()).thenAnswer(
        (realInvocation) async => dummyResonse,
      );

      //act
      final result = await tvRepositories.getPopularTv();

      //assert
      verify(mockdatasource.getPopular()).called(1);
      final resultlist = result.getOrElse(
        () => [],
      );
      expect(resultlist, fakeEntity);
    });
  });

  test('getLIst should return list tv top tv', () async {
    //arrange
    final fakeEntity = listTvEntity;
    when(mockdatasource.getTopRated()).thenAnswer(
      (realInvocation) async => dummyResonse,
    );

    //act
    final result = await tvRepositories.getTopratedTv();

    //assert
    verify(mockdatasource.getTopRated()).called(1);
    final resultlist = result.getOrElse(
      () => [],
    );
    expect(resultlist, fakeEntity);
  });

  test('failed should server failure', () async {
    //arrange
    when(mockdatasource.getTvSeriesOnAiring()).thenThrow(
      ServerException(),
    );

    //act
    final result = await tvRepositories.getListTVonAiring();

    //assert
    verify(mockdatasource.getTvSeriesOnAiring());

    expect(result, equals(Left(ServerFailure(""))));
  });

  test('no connection', () async {
    //arrange
    when(mockdatasource.getTvSeriesOnAiring()).thenThrow(
      SocketException(""),
    );

    //act
    final result = await tvRepositories.getListTVonAiring();

    //assert
    verify(mockdatasource.getTvSeriesOnAiring());

    expect(
        result, equals(Left(ConnectionFailure("Failed to connect network"))));
  });

  group("test detail", () {
    test('getdetail should return list detail', () async {
      //arrange
      final data = TvDetailModel.fromJson(
          jsonDecode(readJson("dummy_data/tv_series_detail.json")));
      final fakeEntity = data.toEntity();
      when(mockdatasource.getTvDetail(2)).thenAnswer(
        (realInvocation) async => data,
      );

      //act
      final result = await tvRepositories.getDetail(2);

      //assert
      verify(mockdatasource.getTvDetail(2)).called(1);
      expect(result, Right(fakeEntity));
    });

    test("if no connect ", () async {
      when(mockdatasource.getTvDetail(2)).thenThrow(
        SocketException(""),
      );

      //act
      final result = await tvRepositories.getDetail(2);

      //assert
      verify(mockdatasource.getTvDetail(2));

      expect(
          result, equals(Left(ConnectionFailure("Failed to connect network"))));
    });
  });

  test('failed should server failure detail', () async {
    //arrange
    when(mockdatasource.getTvDetail(2)).thenThrow(
      ServerException(),
    );

    //act
    final result = await tvRepositories.getDetail(2);

    //assert
    verify(mockdatasource.getTvDetail(2));

    expect(result, equals(Left(ServerFailure(""))));
  });
  group("test get recomendation", () {
    test('getrecomentdation should return list recomendation', () async {
      //arrange
      final data = TvSeriesDetailRecomendation.fromJson(
          jsonDecode(readJson("dummy_data/tv_recomendation.json")));
      final fakedata = data.results
          .map(
            (e) => e.toentity(),
          )
          .toList();
      when(mockdatasource.getRecomendation(2)).thenAnswer(
        (realInvocation) async => data,
      );

      //act
      final result = await tvRepositories.getRecomendation(2);

      //assert
      verify(mockdatasource.getRecomendation(2)).called(1);
      final resultlist = result.getOrElse(
        () => [],
      );
      expect(resultlist, fakedata);
    });

    test("if no connect ", () async {
      when(mockdatasource.getRecomendation(2)).thenThrow(
        SocketException(""),
      );

      //act
      final result = await tvRepositories.getRecomendation(2);

      //assert
      verify(mockdatasource.getRecomendation(2));

      expect(
          result, equals(Left(ConnectionFailure("Failed to connect network"))));
    });

    test('failed should server failure', () async {
      //arrange
      when(mockdatasource.getRecomendation(2)).thenThrow(
        ServerException(),
      );

      //act
      final result = await tvRepositories.getRecomendation(2);

      //assert
      verify(mockdatasource.getRecomendation(2));

      expect(result, equals(Left(ServerFailure(""))));
    });
  });

  group("test get getwatchlist tv", () {
    test('getwatchlist should return list watchlist tv', () async {
      //arrange
      final data = TvSeriesTable.fromMap(testTvmap);
      final TvseriesEntity dataakhir = data.toEntity();
      when(mockTvLoaclDataSource.getWatchlistMovies()).thenAnswer(
        (realInvocation) async => <TvSeriesTable>[data],
      );

      //act
      final result = await tvRepositories.getWatchlistMovies();

      //assert
      verify(mockTvLoaclDataSource.getWatchlistMovies()).called(1);
      final resultlist = result.getOrElse(
        () => [],
      );
      expect(resultlist, <TvseriesEntity>[dataakhir]);
    });

    test("if no connect ", () async {
      when(mockTvLoaclDataSource.getWatchlistMovies()).thenThrow(
        SocketException(""),
      );

      //act
      final result = await tvRepositories.getWatchlistMovies();

      //assert
      verify(mockTvLoaclDataSource.getWatchlistMovies());

      expect(
          result, equals(Left(ConnectionFailure("Failed to connect network"))));
    });

    test('failed should server failure', () async {
      //arrange
      when(mockTvLoaclDataSource.getWatchlistMovies()).thenThrow(
        ServerException(),
      );

      //act
      final result = await tvRepositories.getWatchlistMovies();

      //assert
      verify(mockTvLoaclDataSource.getWatchlistMovies());

      expect(result, equals(Left(ServerFailure(""))));
    });
  });

  group("test get savewatchlist tv", () {
    final TvSeriesDetail dataakhir = TvDetailModel.fromJson(
            jsonDecode(readJson("dummy_data/tv_series_detail.json")))
        .toEntity();
    final TvSeriesTable data = TvSeriesTable.fromEntity(dataakhir);
    test('insert tv should return message', () async {
      //arrange

      when(mockTvLoaclDataSource.insertWatchlist(data)).thenAnswer(
        (realInvocation) async => 'Added to Watchlist',
      );

      //act
      final result = await tvRepositories.saveWatchlist(dataakhir);

      //assert
      verify(mockTvLoaclDataSource.insertWatchlist(data)).called(1);

      expect(result, Right('Added to Watchlist'));
    });

    test("if failed to insert db ", () async {
      when(mockTvLoaclDataSource.insertWatchlist(data)).thenThrow(
        DatabaseException('Failed to add watchlist'),
      );

      //act
      final result = await tvRepositories.saveWatchlist(dataakhir);

      //assert
      verify(mockTvLoaclDataSource.insertWatchlist(data));

      expect(result, equals(Left(DatabaseFailure("Failed to add watchlist"))));
    });
  });
}
