import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/watchlisttvseries/search_watchlistv.dart';
import 'package:equatable/equatable.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchWatchlistTv searchWatchlistTv;
  SearchTvBloc(this.searchWatchlistTv) : super(SearchTvInitial()) {
    on<OnSearchTvQuery>((event, emit) async{
      
      final String query = event.query;
      emit(SearchTvLoading());
      final data = await searchWatchlistTv.excute(query);

      data.fold(
        (l) {
          emit(SearchTvError(l.message));
        }, (r) {
          emit(SearchTvLoaded(r));
        },);
    },);
  }
}
