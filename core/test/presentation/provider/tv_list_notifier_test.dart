import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/usecases/get_tv_on_airing.dart';
import 'package:core/presentation/provider/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvOnAiring
])
void main() {
  late MockGetTvOnAiring getTvOnAiring;
  late TvListNotifier provider;
  setUp(
    () {
      getTvOnAiring = MockGetTvOnAiring();
      provider = TvListNotifier(getTvOnAiring: getTvOnAiring);
    },
  );
  group("test notifier list tv on airing", () {
    test("test get data tv on airing state data should return List<TvOnAiring> and state status should sukses", () async{
      //arrange
      when(getTvOnAiring.execute()).thenAnswer((realInvocation) async => Right(listTvEntity),);
      //act
      await provider.getListTvOnAiring();
      //assert
      expect(provider.status, RequestState.Loaded);
      expect(provider.dataTvSeriesOnAiring, listTvEntity);
    },);
    test("test failed connection status should RequestState.error and state message Failed to connect network", () async{
      //arrange
      when(getTvOnAiring.execute()).thenAnswer((realInvocation) async => Left(ConnectionFailure("Failed to connect network")),);
      //act
      await provider.getListTvOnAiring();
      //assert
      expect(provider.status, RequestState.Error );
      expect(provider.message,"Failed to connect network");
    },);
  },);
}