import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpertvseries.mocks.dart';

void main(){
  late MockTvRepositories mocktv;
  late GetTvSeriesDetail usecase;
  final tvseriesdetialdummy = TvSeriesDetail(name: "", poster_path: "poster_path", overview: "overview", rating: 0.0, reviewer: 3, episode: 12, season: 2);
  setUp((){
    mocktv = MockTvRepositories();
    usecase = GetTvSeriesDetail(mocktv);
  });
  test("should return from repository", ()async{
    final id = 2;
    //arrange
    when(mocktv.getDetail(id)).thenAnswer((realInvocation) async => Right(tvseriesdetialdummy) ,);
    //act
    final result = await usecase.execute(id);
    //assert
    expect(result, Right(tvseriesdetialdummy));
  });
}