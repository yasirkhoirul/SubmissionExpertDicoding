
import 'package:ditonton/data/repositories/tv_repositories_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpertvseries.mocks.dart';

void main(){
  late MockTvSeriesRemoteDataSource mockdatasource;
  late TvRepositoriesImpl tvRepositories;
  setUp(
    (){
      mockdatasource = MockTvSeriesRemoteDataSource();
      tvRepositories = TvRepositoriesImpl(tvdatasource: mockdatasource);
    }
  );

  test('getLIst should return list movie', ()async{
    //arrange
    final fakeEntity = listTvEntity;
    when(mockdatasource.getTvSeriesOnAiring()).thenAnswer((realInvocation) async => dummyResonse,);


    //act
    final result = await tvRepositories.getListTVonAiring();

    //assert
    verify(mockdatasource.getTvSeriesOnAiring()).called(1);
    final resultlist = result.getOrElse(() => [],);
    expect(resultlist, fakeEntity);
  });


}