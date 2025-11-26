import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/cubit/tv_list_cubit.dart';
import 'package:core/presentation/bloc/cubit/tv_list_popular_cubit.dart';
import 'package:core/presentation/bloc/cubit/tv_list_top_rated_cubit.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/tv_list_notifier_test.mocks.dart';
import '../provider/tv_popular_notifier_test.mocks.dart';
import '../provider/tv_top_rated_notifier_test.mocks.dart';

void main() {
  late MockGetPopularTv usecasemockGetPopularTv;
  late MockGetTopRatedTv usecasemockGetTopRatedTv;
  late MockGetTvOnAiring usecaseMockgettvairing;
  late TvListCubit tvListCubit;
  late TvListPopularCubit tvListPopularCubit;
  late TvListTopRatedCubit tvListTopRatedCubit;

  setUp(() {
    usecasemockGetPopularTv = MockGetPopularTv();
    usecasemockGetTopRatedTv = MockGetTopRatedTv();
    usecaseMockgettvairing = MockGetTvOnAiring();

    tvListCubit = TvListCubit(getWatchlistTv: usecaseMockgettvairing);
    tvListPopularCubit = TvListPopularCubit(
      getPopularTv: usecasemockGetPopularTv,
    );
    tvListTopRatedCubit = TvListTopRatedCubit(
      getTopRatedTv: usecasemockGetTopRatedTv,
    );
  });
  group("getting list recomendation", () {
    final datadum = listTvEntity;
    blocTest(
      "getting list tv on airing succes",
      build: () {
        when(
          usecaseMockgettvairing.execute(),
        ).thenAnswer((realInvocation) async => Right(datadum));
        return tvListCubit;
      },
      act: (bloc) => bloc.getListTv(),
      expect: () => [TvListLoading(), TvListLoaded(datadum)],
    );
    blocTest(
      "getting list tv on airing fail conec",
      build: () {
        when(
          usecaseMockgettvairing.execute(),
        ).thenAnswer((realInvocation) async => Left(ConnectionFailure("fail conec")));
        return tvListCubit;
      },
      act: (bloc) => bloc.getListTv(),
      expect: () => [TvListLoading(), TvListEror("fail conec")],
    );
    blocTest(
      "getting list tv on airing fail conec",
      build: () {
        when(
          usecaseMockgettvairing.execute(),
        ).thenAnswer((realInvocation) async => Left(ServerFailure("fail server")));
        return tvListCubit;
      },
      act: (bloc) => bloc.getListTv(),
      expect: () => [TvListLoading(), TvListEror("fail server")],
    );
    
    blocTest(
      "getting list tv on top",
      build: () {
        when(
          usecasemockGetTopRatedTv.execute(),
        ).thenAnswer((realInvocation) async => Right(datadum));
        return tvListTopRatedCubit;
      },
      act: (bloc) => bloc.getToprated(),
      expect: () => [TvListTopRatedLoading(), TvListTopRatedLoaded(datadum)],
    );
    blocTest(
      "getting list tv on top fail conec",
      build: () {
        when(
          usecasemockGetTopRatedTv.execute(),
        ).thenAnswer((realInvocation) async => Left(ConnectionFailure("Fail")));
        return tvListTopRatedCubit;
      },
      act: (bloc) => bloc.getToprated(),
      expect: () => [TvListTopRatedLoading(), TvListTopRatedError("Fail")],
    );
    blocTest(
      "getting list tv on top fail server",
      build: () {
        when(
          usecasemockGetTopRatedTv.execute(),
        ).thenAnswer((realInvocation) async => Left(ServerFailure("Fail")));
        return tvListTopRatedCubit;
      },
      act: (bloc) => bloc.getToprated(),
      expect: () => [TvListTopRatedLoading(), TvListTopRatedError("Fail")],
    );
    blocTest(
      "getting list tv on popular",
      build: () {
        when(
          usecasemockGetPopularTv.execute(),
        ).thenAnswer((realInvocation) async => Right(datadum));
        return tvListPopularCubit;
      },
      act: (bloc) => bloc.getPopularTvList(),
      expect: () => [TvListPopularLoading(), TvListPopularLoaded(datadum)],
    );
    blocTest(
      "getting list tv on popular fail conec",
      build: () {
        when(
          usecasemockGetPopularTv.execute(),
        ).thenAnswer((realInvocation) async => Left(ConnectionFailure("fail")));
        return tvListPopularCubit;
      },
      act: (bloc) => bloc.getPopularTvList(),
      expect: () => [TvListPopularLoading(), TvListPopularError("fail")],
    );
    blocTest(
      "getting list tv on popular fail server",
      build: () {
        when(
          usecasemockGetPopularTv.execute(),
        ).thenAnswer((realInvocation) async => Left(ServerFailure("fail")));
        return tvListPopularCubit;
      },
      act: (bloc) => bloc.getPopularTvList(),
      expect: () => [TvListPopularLoading(), TvListPopularError("fail")],
    );
  });
}
