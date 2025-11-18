import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/tv_repositories_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpertvseries.mocks.dart';

void main() {
  late MockTvSeriesRemoteDataSource mockdatasource;
  late TvRepositoriesImpl tvRepositories;
  setUp(() {
    mockdatasource = MockTvSeriesRemoteDataSource();
    tvRepositories = TvRepositoriesImpl(tvdatasource: mockdatasource, tvLoaclDataSource: );
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

    expect(result, equals(Left(ConnectionFailure("Failed to connect network"))));
  });
}
