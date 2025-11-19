import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recomendation.dart';
import 'package:ditonton/domain/usecases/watchlisttvseries/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/watchlisttvseries/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/watchlisttvseries/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail,GetTvSeriesRecomendation,SaveWatchlistTv,RemoveWatchlistTv,GetWatchlistStatusTv])
void main() {
  late GetTvSeriesRecomendation getTvSeriesRecomendation;
  late MockGetTvSeriesDetail gettvseriesdetail;
  late MockRemoveWatchlistTv removeWatchlistTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockGetWatchlistStatusTv mockGetWatchlistStatusTv;
  late TvSeriesDetailNotifier provider;
  setUp(() {
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockGetWatchlistStatusTv = MockGetWatchlistStatusTv();
    removeWatchlistTv = MockRemoveWatchlistTv();
    getTvSeriesRecomendation = MockGetTvSeriesRecomendation();
    gettvseriesdetail = MockGetTvSeriesDetail();
    provider = TvSeriesDetailNotifier(getMovieDetail: gettvseriesdetail, getTvSeriesRecomendation: getTvSeriesRecomendation, saveWatchlistTv: mockSaveWatchlistTv, getWatchListStatus: mockGetWatchlistStatusTv, removeWatchlistTv: removeWatchlistTv);
  });
    final datadummy = TvSeriesDetail(
        name: "",
        poster_path: "poster_path",
        overview: "0.0,",
        rating: 0.0,
        reviewer: 2,
        episode: 2,
        season: 12, id: 1);
      final int id = 2;
  group("test notifier", () {
    test("Request state should loaded and data state should have entities", () async{
      //arrange
      when(gettvseriesdetail.execute(id)).thenAnswer((_) async => Right(datadummy));
      //act
      await provider.getDetail(id);
      //assert
      expect(provider.datadetail, datadummy);
      expect(provider.status, RequestState.Loaded);
    });

    test("if connection failed should have message connection fail", ()async{
      when(gettvseriesdetail.execute(id)).thenAnswer((realInvocation)async => Left(ConnectionFailure("fail")),);

      await provider.getDetail(id);

      expect(provider.message, "fail");
      expect(provider.status, RequestState.Error);
    });
  });
  group("test loadwatchlist", () {
    
    test("should check by id and return true ", () async{
      when(mockGetWatchlistStatusTv.execute(id)).thenAnswer((realInvocation)async => true,);

      await provider.loadWatchlistStatus(id);

      expect(provider.isAddedWatchlist, true);
    });

    test("should check by id and return false", ()async{
      when(mockGetWatchlistStatusTv.execute(id)).thenAnswer((realInvocation)async => false,);

      await provider.loadWatchlistStatus(id);

      expect(provider.isAddedWatchlist, false);
    });
  });

  group("test addWatchlist", () {
    
    test("should return message succes", () async{
      when(mockSaveWatchlistTv.execute(datadummy)).thenAnswer((realInvocation)async => Right("succes"),);

      when(mockGetWatchlistStatusTv.execute(datadummy.id))
      .thenAnswer((realInvocation) async => true);
      
      await provider.addWatchlist(datadummy);

      expect(provider.watchlistmessage, "succes");
    });

    test("should return Failure", ()async{
      when(mockSaveWatchlistTv.execute(datadummy)).thenAnswer((realInvocation)async => Left(DatabaseFailure("masalah database")),);

      when(mockGetWatchlistStatusTv.execute(datadummy.id))
      .thenAnswer((realInvocation) async => false);
      
      await provider.addWatchlist(datadummy);

      expect(provider.watchlistmessage, "masalah database");
    });

    test("remove watchlist succes ", ()async{
      when(removeWatchlistTv.excute(datadummy)).thenAnswer((realInvocation)async => Right("sukes dihapus"),);

      when(mockGetWatchlistStatusTv.execute(datadummy.id))
      .thenAnswer((realInvocation) async => true);
      
      await provider.removeWatchLIst(datadummy);

      expect(provider.watchlistmessage, "sukes dihapus");
    });
  });
}
