part of 'get_detail_tv_series_bloc.dart';

class GetDetailTvSeriesState extends Equatable {
  final String detailmessage;
  final TvSeriesDetail? tvSeriesDetail;
  final RequestState tvseriesstatus;

  final String watchlistmessage;
  final bool watchliststatus;

  const GetDetailTvSeriesState({
    this.detailmessage = "",
    this.tvSeriesDetail,
    this.tvseriesstatus = RequestState.Empty,
    this.watchlistmessage = "",
    this.watchliststatus = false,
  });

  GetDetailTvSeriesState copyWith({
    String? detailmessage,
    TvSeriesDetail? tvSeriesDetail,
    RequestState? requestState,
    String? watchlistmessage,
    bool? watchlisstatuss,
  }) {
    return GetDetailTvSeriesState(
      tvSeriesDetail: tvSeriesDetail ?? this.tvSeriesDetail,
      tvseriesstatus: requestState?? tvseriesstatus,
      detailmessage: detailmessage ?? this.detailmessage,
      watchliststatus: watchlisstatuss ?? watchliststatus,
      watchlistmessage: watchlistmessage ?? this.watchlistmessage,
    );
  }

  @override
  List<Object?> get props => [
    detailmessage,
    tvSeriesDetail,
    tvseriesstatus,
    watchlistmessage,
    watchliststatus,
  ];
}

// //detail tv
// final class GetDetailTvSeriesInitial extends GetDetailTvSeriesState {}
// final class GetDetailTvSeriesLoading extends GetDetailTvSeriesState {}
// final class GetDetailTvSeriesError extends GetDetailTvSeriesState {
//   final String message;
//   const GetDetailTvSeriesError(this.message);

//   @override
//   List<Object> get props => [message];
// }
// final class GetDetailTvSeriesLoaded extends GetDetailTvSeriesState {
//   final TvSeriesDetail data;
//   const GetDetailTvSeriesLoaded(this.data);

//   @override
//   List<Object> get props => [data];
// }

// //watchlist
// final class TvAddWatchListLoading extends GetDetailTvSeriesState{}
// final class TvAddWatchListError extends GetDetailTvSeriesState{
//   final String message;
//   const TvAddWatchListError(this.message);

//   @override
//   List<Object> get props => [message];
// }
// final class TvAddWatchListLoaded extends GetDetailTvSeriesState{
//   final String message;
//   const TvAddWatchListLoaded(this.message);

//   @override
//   List<Object> get props => [message];
// }
// final class IsAddedWatchlist extends GetDetailTvSeriesState{
//   final bool status;
//   const IsAddedWatchlist(this.status);

//   @override
//   List<Object> get props => [status];
// }
