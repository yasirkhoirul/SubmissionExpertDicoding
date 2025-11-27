part of 'popular_movie_cubit.dart';

sealed class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

final class PopularMovieInitial extends PopularMovieState {}
final class PopularMovieLoading extends PopularMovieState {}
final class PopularMovieError extends PopularMovieState {
  final String message;
  const PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}
final class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> data;
  const PopularMovieLoaded(this.data);

  @override
  List<Object> get props => [data];
}
