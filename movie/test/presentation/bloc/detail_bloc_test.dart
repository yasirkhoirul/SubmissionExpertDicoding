import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/cubit/movie_detail_cubit.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';

void main() {
  late MovieDetailCubit cubit;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    cubit = MovieDetailCubit(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

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
  final tId = 1;
  void arrangeUsecase() {
    when(
      mockGetMovieDetail.execute(tId),
    ).thenAnswer((_) async => Right(testMovieDetail));
    when(
      mockGetMovieRecommendations.execute(tId),
    ).thenAnswer((_) async => Right([tMovie]));
  }

  group("testing detail", () {
    blocTest(
      "get detail succes rec",
      build: () {
        arrangeUsecase();
        return cubit;
      },
      act: (MovieDetailCubit bloc) => bloc.fetchMovieDetail(tId),
      expect: () => [
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: null,
          statusDetail: RequestState.Loading,
          statusRecomendation: RequestState.Empty,
          watchlismessage: '',
        ),
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: testMovieDetail,
          statusDetail: RequestState.Loading,
          statusRecomendation: RequestState.Empty,
          watchlismessage: '',
        ),
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: testMovieDetail,
          statusDetail: RequestState.Loaded,
          statusRecomendation: RequestState.Empty,
          watchlismessage: '',
        ),
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: testMovieDetail,
          statusDetail: RequestState.Loaded,
          statusRecomendation: RequestState.Loading,
          watchlismessage: '',
        ),
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: testMovieDetail,
          statusDetail: RequestState.Loaded,
          statusRecomendation: RequestState.Loaded,
          watchlismessage: '',
        ),
        MovieDetailState(
          datalistrecomendation: [tMovie],
          message: '',
          isAddedWatchList: false,
          movieDetail: testMovieDetail,
          statusDetail: RequestState.Loaded,
          statusRecomendation: RequestState.Loaded,
          watchlismessage: '',
        ),
      ],
    );
    blocTest(
      "get detail fail rec",
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => Right([tMovie]));
        return cubit;
      },
      act: (MovieDetailCubit bloc) => bloc.fetchMovieDetail(tId),
      expect: () => [
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: null,
          statusDetail: RequestState.Loading,
          statusRecomendation: RequestState.Empty,
          watchlismessage: '',
        ),
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: null,
          statusDetail: RequestState.Error,
          statusRecomendation: RequestState.Empty,
          watchlismessage: '',
        ),
        MovieDetailState(
          datalistrecomendation: [],
          message: 'Server Failure',
          isAddedWatchList: false,
          movieDetail: null,
          statusDetail: RequestState.Error,
          statusRecomendation: RequestState.Empty,
          watchlismessage: '',
        ),
      ],
    );
    blocTest(
      "add watchlist succes",
      build: () {
        when(
          mockSaveWatchlist.execute(testMovieDetail),
        ).thenAnswer((_) async => Right('Added to Watchlist'));
        when(
          mockGetWatchlistStatus.execute(testMovieDetail.id),
        ).thenAnswer((_) async => true);
        return cubit;
      },
      act: (MovieDetailCubit bloc) => bloc.addWatchlist(testMovieDetail),
      expect: () => [
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: null,
          statusDetail: RequestState.Empty,
          statusRecomendation: RequestState.Empty,
          watchlismessage: 'Added to Watchlist',
        ),
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: true,
          movieDetail: null,
          statusDetail: RequestState.Empty,
          statusRecomendation: RequestState.Empty,
          watchlismessage: 'Added to Watchlist',
        ),
      ],
    );
    blocTest(
      "add watchlist fail",
      build: () {
        when(
          mockSaveWatchlist.execute(testMovieDetail),
        ).thenAnswer((_) async => Left(DatabaseFailure("fail")));
        when(
          mockGetWatchlistStatus.execute(testMovieDetail.id),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (MovieDetailCubit bloc) => bloc.addWatchlist(testMovieDetail),
      expect: () => [
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: null,
          statusDetail: RequestState.Empty,
          statusRecomendation: RequestState.Empty,
          watchlismessage: 'fail',
        ),
      ],
    );
    blocTest(
      "remove watchlist succes",
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
        return cubit;
      },
      act: (MovieDetailCubit bloc) => bloc.removeFromWatchlist(testMovieDetail),
      expect: () => [
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: null,
          statusDetail: RequestState.Empty,
          statusRecomendation: RequestState.Empty,
          watchlismessage: 'Removed',
        ),
      ],
    );
    blocTest(
      "add watchlist fail",
      build: () {
        when(
          mockRemoveWatchlist.execute(testMovieDetail),
        ).thenAnswer((_) async => Left(DatabaseFailure("fail")));
        when(
          mockGetWatchlistStatus.execute(testMovieDetail.id),
        ).thenAnswer((_) async => false);
        return cubit;
      },
      act: (MovieDetailCubit bloc) => bloc.removeFromWatchlist(testMovieDetail),
      expect: () => [
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: null,
          statusDetail: RequestState.Empty,
          statusRecomendation: RequestState.Empty,
          watchlismessage: 'fail',
        ),
      ],
    );

    blocTest("should get status", build: () {
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      return cubit;
    },
    act: (MovieDetailCubit bloc) => bloc.loadWatchlistStatus(1),
    expect: () =>  [MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: true,
          movieDetail: null,
          statusDetail: RequestState.Empty,
          statusRecomendation: RequestState.Empty,
          watchlismessage: 'fail',
        ),]
    );
  });
}
