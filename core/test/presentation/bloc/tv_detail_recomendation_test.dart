import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/data/models/tv_series_detail_recomendation.dart';
import 'package:core/presentation/bloc/cubit/get_recomedation_detail_tv_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../provider/tv_detail_notifier_test.mocks.dart';

void main() {
  late MockGetTvSeriesRecomendation mockusecaseGetrecomendation;
  late GetRecomedationDetailTvCubit blocGetRecomendation;

  setUp(() {
    mockusecaseGetrecomendation = MockGetTvSeriesRecomendation();
    blocGetRecomendation = GetRecomedationDetailTvCubit(
      getTvSeriesRecomendation: mockusecaseGetrecomendation,
    );
  });

  final data = TvSeriesDetailRecomendation.fromJson(
    jsonDecode(readJson("dummy_data/tv_recomendation.json")),
  );
  final datadum = data.results.map((e) => e.toentity()).toList();
  group("testing recomendation", () {
    blocTest(
      "testing recomendation on succes",
      build: () {
        when(
          mockusecaseGetrecomendation.execute(1),
        ).thenAnswer((realInvocation) async => Right(datadum));
        return blocGetRecomendation;
      },
      act: ( GetRecomedationDetailTvCubit bloc) => bloc.getRecomendation(1),

      expect: () => [
        GetRecomendationDetailTvLoading(),
        GetRecomendationDetailTvLoaded(datadum),
      ],
    );
    blocTest(
      "testing recomendation on fail conec",
      build: () {
        when(
          mockusecaseGetrecomendation.execute(1),
        ).thenAnswer((realInvocation) async => Left(ConnectionFailure("Fail")));
        return blocGetRecomendation;
      },
      act: (GetRecomedationDetailTvCubit bloc) => bloc.getRecomendation(1),

      expect: () => [
        GetRecomendationDetailTvLoading(),
        GetRecomendationDetailTvError("Fail"),
      ],
    );
    blocTest(
      "testing recomendation on fail sever",
      build: () {
        when(
          mockusecaseGetrecomendation.execute(1),
        ).thenAnswer((realInvocation) async => Left(ServerFailure("Fail")));
        return blocGetRecomendation;
      },
      act: (GetRecomedationDetailTvCubit bloc) => bloc.getRecomendation(1),

      expect: () => [
        GetRecomendationDetailTvLoading(),
        GetRecomendationDetailTvError("Fail"),
      ],
    );
  });
}
