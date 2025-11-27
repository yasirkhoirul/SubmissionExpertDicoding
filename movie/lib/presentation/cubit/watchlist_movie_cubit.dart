import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMovieCubit(this.getWatchlistMovies) : super(WatchlistMovieInitial());
  Future<void> getwatchlistMovie() async {
    emit(WatchlistMovieLoading());
    final response = await getWatchlistMovies.execute();
    response.fold(
      (l) {
        emit(WatchlistMovieError(l.message));
      }, (r) {
        emit(WatchlistMovieLoaded(r));
      },);
  }
}
