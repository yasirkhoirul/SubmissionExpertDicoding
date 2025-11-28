import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';

part 'popular_movie_state.dart';

class PopularMovieCubit extends Cubit<PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieCubit(this.getPopularMovies) : super(PopularMovieInitial());

  Future<void> getPopularMovie() async {
    emit(PopularMovieLoading());
    final response = await getPopularMovies.execute();
    response.fold(
      (l) {
        emit(PopularMovieError(l.message));
      },
      (r) {
        emit(PopularMovieLoaded(r));
      },
    );
  }
}
