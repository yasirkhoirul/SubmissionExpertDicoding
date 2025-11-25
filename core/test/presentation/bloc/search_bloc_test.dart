
import 'package:core/core.dart';
import 'package:core/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/usecases/search_movies.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main(){

  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  setUp((){
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchBloc(searchMovies: mockSearchMovies);
  });

  test("should return initial state", (){
    expect(searchBloc.state,SearchInitial() );
  });


  blocTest<SearchBloc, SearchState>(
    'if search succes',
    build: () {
      when(mockSearchMovies.execute("keke")).thenAnswer((realInvocation) async => Right([testMovie]) ,);
      return searchBloc;
    },
    wait: const Duration(milliseconds: 100),
    act: (bloc) => bloc.add(OnQueryChanged("keke")),
    expect: () => <SearchState>[SearchLoading(),SearchHasData([testMovie])],
    verify: (bloc) => verify(mockSearchMovies.execute("keke")),
  );
  blocTest<SearchBloc, SearchState>(
    'if search failed',
    build: () {
      when(mockSearchMovies.execute("keke")).thenAnswer((realInvocation) async => Left(ServerFailure("error")),);
      return searchBloc;
    },
    wait: const Duration(milliseconds: 100),
    act: (bloc) => bloc.add(OnQueryChanged("keke")),
    expect: () => <SearchState>[SearchLoading(),SearchError("error")],
    verify: (bloc) => verify(mockSearchMovies.execute("keke")),
  );
}