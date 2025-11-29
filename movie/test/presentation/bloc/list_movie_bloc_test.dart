import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/cubit/list_movie_cubit.dart';

import '../provider/movie_list_notifier_test.mocks.dart';

void main(){
  late GetNowPlayingMovies usecaseGetNowPlaying;
  late ListMovieCubit cubit;

  setUp(
    () {
      usecaseGetNowPlaying = MockGetNowPlayingMovies();
      cubit = ListMovieCubit(usecaseGetNowPlaying);
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
  group("testing popular cubit", () {
    blocTest("testing succes and return list data movie popular", build: (){
      when(usecaseGetNowPlaying.execute()).thenAnswer((realInvocation) async => Right(tMovieList) ,);
      return cubit;
    },
    act: (ListMovieCubit bloc) => bloc.getListMovie(),
    expect: () => [ListMovieLoading(),ListMovieLoaded(tMovieList)],
    );
    blocTest("testing fail conec and return message", build: (){
      when(usecaseGetNowPlaying.execute()).thenAnswer((realInvocation) async => Left(ConnectionFailure("koneksi gagal")) ,);
      return cubit;
    },
    act: (ListMovieCubit bloc) => bloc.getListMovie(),
    expect: () => [ListMovieLoading(),ListMovieError("koneksi gagal")],
    );
    blocTest("testing fail server and return message", build: (){
      when(usecaseGetNowPlaying.execute()).thenAnswer((realInvocation) async => Left(ServerFailure("koneksi server gagal")) ,);
      return cubit;
    },
    act: (ListMovieCubit bloc) => bloc.getListMovie(),
    expect: () => [ListMovieLoading(),ListMovieError("koneksi server gagal")],
    );
  },);
}