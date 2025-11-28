import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/get_tv_on_airing.dart';
import 'package:equatable/equatable.dart';

part 'tv_list_state.dart';

class TvListCubit extends Cubit<TvListState> {
  final GetTvOnAiring getWatchlistTv;
  TvListCubit({required this.getWatchlistTv}) : super(TvListInitial());

  void getListTv() async {
    emit(TvListLoading());
    final data = await getWatchlistTv.execute();
    data.fold(
      (l) {
        emit(TvListEror(l.message));
      },
      (r) {
        emit(TvListLoaded(r));
      },
    );
  }
}
