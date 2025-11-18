import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';
import 'package:ditonton/domain/usecases/get_tv_on_airing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpertvseries.mocks.dart';

void main(){
  late TvRepositories tvRepo;
  late GetTvOnAiring usecase;
  final List<TvseriesEntity> tv = [];
  setUp(() {
    tvRepo = MockTvRepositories();
    usecase = GetTvOnAiring(tvrepo: tvRepo);
  },);
  test('usecase should return from repository', ()async{
    //arrange
    when(tvRepo.getListTVonAiring()).thenAnswer((realInvocation) async => Right(tv), );
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tv));
  });
}