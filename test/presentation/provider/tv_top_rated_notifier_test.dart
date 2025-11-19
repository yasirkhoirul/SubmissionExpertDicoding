import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/provider/tv_top_rated_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_top_rated_notifier_test.mocks.dart';

@GenerateMocks([
  GetTopRatedTv
])
void main(){
  late MockGetTopRatedTv getTopRatedTv;
  late TvTopRatedNotifier provider;
  setUp(
    () {
      getTopRatedTv = MockGetTopRatedTv();
      provider = TvTopRatedNotifier(getTopRatedTv: getTopRatedTv);
    },
  );
  group("test notifier list tv on airing", () {
    test("test get data tv on airing state data should return List<TvOnAiring> and state status should sukses", () async{
      //arrange
      when(getTopRatedTv.execute()).thenAnswer((realInvocation) async => Right(listTvEntity),);
      //act
      await provider.getToprated();
      //assert
      expect(provider.status, RequestState.Loaded);
      expect(provider.dataTopRated, listTvEntity);
    },);
    test("test failed connection status should RequestState.error and state message Failed to connect network", () async{
      //arrange
      when(getTopRatedTv.execute()).thenAnswer((realInvocation) async => Left(ConnectionFailure("Failed to connect network")),);
      //act
      await provider.getToprated();
      //assert
      expect(provider.status, RequestState.Error );
      expect(provider.message,"Failed to connect network");
    },);
  },);
}