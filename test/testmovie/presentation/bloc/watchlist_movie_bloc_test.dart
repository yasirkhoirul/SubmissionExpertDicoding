import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/presentation/cubit/watchlist_movie_cubit.dart';

import 'watchlist_movie_bloc_test.mocks.dart';


@GenerateMocks([GetWatchlistMovies])
void main(){
  late GetWatchlistMovies usecaseWatchlist;
  late WatchlistMovieCubit cubit;

  setUp(
    () {
      usecaseWatchlist = MockGetWatchlistMovies();
      cubit = WatchlistMovieCubit(usecaseWatchlist);
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
      when(usecaseWatchlist.execute()).thenAnswer((realInvocation) async => Right(tMovieList) ,);
      return cubit;
    },
    act: (WatchlistMovieCubit bloc) => bloc.getwatchlistMovie(),
    expect: () => [WatchlistMovieLoading(),WatchlistMovieLoaded(tMovieList)],
    );
    blocTest("testing fail conec and return message", build: (){
      when(usecaseWatchlist.execute()).thenAnswer((realInvocation) async => Left(ConnectionFailure("koneksi gagal")) ,);
      return cubit;
    },
    act: (WatchlistMovieCubit bloc) => bloc.getwatchlistMovie(),
    expect: () => [WatchlistMovieLoading(),WatchlistMovieError("koneksi gagal")],
    );
    blocTest("testing fail server and return message", build: (){
      when(usecaseWatchlist.execute()).thenAnswer((realInvocation) async => Left(ServerFailure("koneksi server gagal")) ,);
      return cubit;
    },
    act: (WatchlistMovieCubit bloc) => bloc.getwatchlistMovie(),
    expect: () => [WatchlistMovieLoading(),WatchlistMovieError("koneksi server gagal")],
    );
  },);
}