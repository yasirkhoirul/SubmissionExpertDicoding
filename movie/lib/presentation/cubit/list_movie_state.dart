part of 'list_movie_cubit.dart';

sealed class ListMovieState extends Equatable {
  const ListMovieState();

  @override
  List<Object> get props => [];
}

final class ListMovieInitial extends ListMovieState {}

final class ListMovieLoading extends ListMovieState {}

final class ListMovieError extends ListMovieState {
  final String message;
  const ListMovieError(this.message);

  @override
  List<Object> get props => [message];
}

final class ListMovieLoaded extends ListMovieState {
  final List<Movie> data;
  const ListMovieLoaded(this.data);
  @override
  List<Object> get props => [data];
}
