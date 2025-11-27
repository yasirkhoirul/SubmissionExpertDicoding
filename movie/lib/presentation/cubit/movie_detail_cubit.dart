import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  MovieDetailCubit(
    this.getMovieDetail,
    this.getMovieRecommendations,
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(
        MovieDetailState(
          datalistrecomendation: [],
          message: '',
          isAddedWatchList: false,
          movieDetail: null,
          statusDetail: RequestState.Empty,
          statusRecomendation: RequestState.Empty, 
          watchlismessage: '',
        ),
      );

  Future fetchMovieDetail(int id) async {
    emit(state.copyWith(statusDetail: RequestState.Loading));
    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        emit(state.copyWith(statusDetail: RequestState.Error));
        emit(state.copyWith(message: failure.message));
      },
      (movie) {
        emit(state.copyWith(movieDetail: movie));
        emit(state.copyWith(statusDetail: RequestState.Loaded));
        emit(state.copyWith(statusRecomendation: RequestState.Loading));
        recommendationResult.fold(
          (failure) {
            emit(state.copyWith(statusRecomendation: RequestState.Error));
            emit(state.copyWith(message: failure.message));
          },
          (movies) {
            emit(state.copyWith(statusRecomendation: RequestState.Loaded));
           emit(state.copyWith(datalistrecomendation: movies));
          },
        );
      },
    );
  }

  Future addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);
    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlismessage: failure.message));
      },
      (successMessage) async {
        emit(state.copyWith(watchlismessage: successMessage));
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        emit(state.copyWith(watchlismessage: failure.message));
      },
      (successMessage) async {
       emit(state.copyWith(watchlismessage: successMessage));
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(state.copyWith(isAddedWatchList: result));
  }
}
