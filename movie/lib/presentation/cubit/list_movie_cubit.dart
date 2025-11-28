import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';

part 'list_movie_state.dart';

class ListMovieCubit extends Cubit<ListMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  ListMovieCubit(this.getNowPlayingMovies) : super(ListMovieInitial());

  Future<void> getListMovie() async {
    emit(ListMovieLoading());

    final response = await getNowPlayingMovies.execute();
    response.fold(
      (l) {
        emit(ListMovieError(l.message));
      },
      (r) {
        emit(ListMovieLoaded(r));
      },
    );
  }
}
