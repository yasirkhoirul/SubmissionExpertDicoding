
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:ditonton/presentation/provider/tv_popular_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_popular_notifier.mocks.dart';

@GenerateMocks([
  GetPopularTv,
])
void main(){
  late MockGetPopularTv getPopularTv;
  late TvPopularNotifier provider;
  setUp((){
    getPopularTv = MockGetPopularTv();
    provider = TvPopularNotifier(getPopularTv: getPopularTv);
  });

  group("test provider tv popular", (){
    test("should Request state loaded and state data have Popular list", ()async{
    //arrange
    when(getPopularTv.execute()).thenAnswer((realInvocation) async => Right(listTvEntity) ,);
    //act
    await provider.getPopular();

    //assert
    expect(provider.status, RequestState.Loaded);
    expect(provider.dataPopular, listTvEntity);
  });
   test("test failed connection status should RequestState.error and state message Failed to connect network", () async{
      //arrange
      when(getPopularTv.execute()).thenAnswer((realInvocation) async => Left(ConnectionFailure("Failed to connect network")),);
      //act
      await provider.getPopular();
      //assert
      expect(provider.status, RequestState.Error );
      expect(provider.message,"Failed to connect network");
    },);
  });


}