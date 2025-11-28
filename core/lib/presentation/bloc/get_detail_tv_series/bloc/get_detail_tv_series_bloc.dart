import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:core/domain/usecases/watchlisttvseries/get_watchlist_status.dart';
import 'package:core/domain/usecases/watchlisttvseries/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/watchlisttvseries/save_watchlist_tv.dart';
import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';

part 'get_detail_tv_series_event.dart';
part 'get_detail_tv_series_state.dart';

class GetDetailTvSeriesBloc
    extends Bloc<GetDetailTvSeriesEvent, GetDetailTvSeriesState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetWatchlistStatusTv getWatchListStatus;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;
  GetDetailTvSeriesBloc(
    this.getTvSeriesDetail,
    this.saveWatchlistTv, {
    required this.getWatchListStatus,
    required this.removeWatchlistTv,
  }) : super(GetDetailTvSeriesState()) {
    on<OnDetailTvSeriesE>((event, emit) async {
      final id = event.id;
      emit(state.copyWith(requestState: RequestState.Loading));

      final data = await getTvSeriesDetail.execute(id);
      data.fold(
        (l) {
          emit(
            state.copyWith(
              requestState: RequestState.Error,
              detailmessage: l.message,
            ),
          );
        },
        (r) {
          emit(
            state.copyWith(
              tvSeriesDetail: r,
              requestState: RequestState.Loaded,
            ),
          );
        },
      );
    });

    on<OnAddWatchListTv>((event, emit) async {
      final data = event.data;
      final respose = await saveWatchlistTv.execute(data);

      respose.fold(
        (l) {
          emit(state.copyWith(watchlistmessage: l.message));
        },
        (r) {
          emit(state.copyWith(watchlistmessage: r));
          emit(state.copyWith(watchlisstatuss: true));
        },
      );
    });

    on<IsAddedOnWatchList>((event, emit) async {
      final id = event.id;
      final result = await getWatchListStatus.execute(id);
      emit(state.copyWith(watchlisstatuss: result));
    });
    on<OnRemoveWatchListTv>((event, emit) async {
      final data = event.data;
      final result = await removeWatchlistTv.excute(data);
      result.fold(
        (l) {
          emit(state.copyWith(watchlistmessage: l.message));
        },
        (r) {
          emit(state.copyWith(watchlistmessage: r));
          emit(state.copyWith(watchlisstatuss: false));
        },
      );
    });
  }
}
