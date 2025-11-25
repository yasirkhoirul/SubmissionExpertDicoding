import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:core/domain/usecases/search_movies.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies searchMovies;
  SearchBloc({required this.searchMovies}) : super(SearchInitial()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(SearchLoading());
      final response = await searchMovies.execute(query);

      response.fold(
        (l) {
          emit(SearchError(l.message));
        },
        (r) {
          emit(SearchHasData(r));
        },
      );
    });
  }
}
