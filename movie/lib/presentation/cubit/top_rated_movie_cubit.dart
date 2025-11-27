import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movie_state.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMovieCubit(this.getTopRatedMovies) : super(TopRatedMovieInitial());

  Future<void> getToprated() async {
    emit(TopRatedMovieLoading());
    final response = await getTopRatedMovies.execute();
    response.fold(
      (l) {
        emit(TopRatedMovieError(l.message));
      }, (r) {
        emit(TopRatedMovieLoaded(r));
      },);
  }
}
