part of 'watchlist_movie_cubit.dart';

sealed class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

final class WatchlistMovieInitial extends WatchlistMovieState {}
final class WatchlistMovieLoading extends WatchlistMovieState {}
final class WatchlistMovieError extends WatchlistMovieState {
  final String message;
  const WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}
final class WatchlistMovieLoaded extends WatchlistMovieState {
  final List<Movie> data;
  const WatchlistMovieLoaded(this.data);

  @override
  List<Object> get props => [data];
}
