part of 'get_detail_tv_series_bloc.dart';

sealed class GetDetailTvSeriesEvent extends Equatable {
  const GetDetailTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnDetailTvSeriesE extends GetDetailTvSeriesEvent {
  final int id;
  const OnDetailTvSeriesE(this.id);

  @override
  List<Object> get props => [id];
}

class OnAddWatchListTv extends GetDetailTvSeriesEvent {
  final TvSeriesDetail data;
  const OnAddWatchListTv(this.data);

  @override
  List<Object> get props => [data];
}

class OnRemoveWatchListTv extends GetDetailTvSeriesEvent {
  final TvSeriesDetail data;
  const OnRemoveWatchListTv(this.data);

  @override
  List<Object> get props => [data];
}

class IsAddedOnWatchList extends GetDetailTvSeriesEvent {
  final int id;
  const IsAddedOnWatchList(this.id);

  @override
  List<Object> get props => [id];
}
