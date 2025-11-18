import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recomendation.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail,GetTvSeriesRecomendation])
void main() {
  late GetTvSeriesRecomendation getTvSeriesRecomendation;
  late MockGetTvSeriesDetail gettvseriesdetail;
  late TvSeriesDetailNotifier provider;
  setUp(() {
    getTvSeriesRecomendation = MockGetTvSeriesRecomendation();
    gettvseriesdetail = MockGetTvSeriesDetail();
    provider = TvSeriesDetailNotifier(getMovieDetail: gettvseriesdetail, getTvSeriesRecomendation: getTvSeriesRecomendation);
  });
  group("test notifier", () {
    final datadummy = TvSeriesDetail(
        name: "",
        poster_path: "poster_path",
        overview: "0.0,",
        rating: 0.0,
        reviewer: 2,
        episode: 2,
        season: 12);
      final int id = 2;
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
}
