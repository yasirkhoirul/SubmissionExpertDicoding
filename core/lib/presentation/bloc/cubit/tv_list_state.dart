part of 'tv_list_cubit.dart';

sealed class TvListState extends Equatable {
  const TvListState();

  @override
  List<Object> get props => [];
}

final class TvListInitial extends TvListState {}

final class TvListLoading extends TvListState {}
final class TvListEror extends TvListState {
  final String message;
  const TvListEror(this.message);

  @override
  List<Object> get props => [message];
}
final class TvListLoaded extends TvListState {
  final List<TvseriesEntity> data;
  const TvListLoaded(this.data);

  @override
  List<Object> get props => [data];
}
