import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/watchlisttvseries/search_watchlistv.dart';
import 'package:core/presentation/bloc/search_tv_bloc/bloc/search_tv_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchWatchlistTv])
void main() {
  late MockSearchWatchlistTv usecase;
  late SearchTvBloc searchTvBloc;

  setUp(() {
    usecase = MockSearchWatchlistTv();
    searchTvBloc = SearchTvBloc(usecase);
  });

  group("testing bloc tv search", () {
    final dummyData = listTvEntity;
    blocTest(
      "should return list data tv entitiy",

      build: () {
        when(
          usecase.excute("lala"),
        ).thenAnswer((realInvocation) async => Right(dummyData));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnSearchTvQuery("lala")),
      expect: () => [SearchTvLoading(), SearchTvLoaded(dummyData)],
    );
    blocTest(
      "should return fail server",

      build: () {
        when(
          usecase.excute("lala"),
        ).thenAnswer((realInvocation) async => Left(ServerFailure("")));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnSearchTvQuery("lala")),
      expect: () => [SearchTvLoading(), SearchTvError("")],
    );
    blocTest(
      "should return fail conec",

      build: () {
        when(
          usecase.excute("lala"),
        ).thenAnswer((realInvocation) async => Left(ConnectionFailure("")));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnSearchTvQuery("lala")),
      expect: () => [SearchTvLoading(), SearchTvError("")],
    );
  });
}
