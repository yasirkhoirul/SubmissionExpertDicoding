import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/cubit/top_rated_movie_cubit.dart';

import '../provider/movie_list_notifier_test.mocks.dart';

void main(){
  late GetTopRatedMovies usecaseGetTopRated;
  late TopRatedMovieCubit cubit;

  setUp(
    () {
      usecaseGetTopRated = MockGetTopRatedMovies();
      cubit = TopRatedMovieCubit(usecaseGetTopRated);
    },
  );

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];
  group("testing TopRated cubit", () {
    blocTest("testing succes and return list data movie TopRated", build: (){
      when(usecaseGetTopRated.execute()).thenAnswer((realInvocation) async => Right(tMovieList) ,);
      return cubit;
    },
    act: (bloc) => bloc.getToprated(),
    expect: () => [TopRatedMovieLoading(),TopRatedMovieLoaded(tMovieList)],
    );
    blocTest("testing fail conec and return message", build: (){
      when(usecaseGetTopRated.execute()).thenAnswer((realInvocation) async => Left(ConnectionFailure("koneksi gagal")) ,);
      return cubit;
    },
    act: (bloc) => bloc.getToprated(),
    expect: () => [TopRatedMovieLoading(),TopRatedMovieError("koneksi gagal")],
    );
    blocTest("testing fail server and return message", build: (){
      when(usecaseGetTopRated.execute()).thenAnswer((realInvocation) async => Left(ServerFailure("koneksi server gagal")) ,);
      return cubit;
    },
    act: (bloc) => bloc.getToprated(),
    expect: () => [TopRatedMovieLoading(),TopRatedMovieError("koneksi server gagal")],
    );
  },);
}