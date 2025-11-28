part of 'tv_list_popular_cubit.dart';

sealed class TvListPopularState extends Equatable {
  const TvListPopularState();

  @override
  List<Object> get props => [];
}

final class TvListPopularInitial extends TvListPopularState {}

final class TvListPopularLoading extends TvListPopularState {}

final class TvListPopularError extends TvListPopularState {
  final String message;
  const TvListPopularError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvListPopularLoaded extends TvListPopularState {
  final List<TvseriesEntity> data;
  const TvListPopularLoaded(this.data);

  @override
  List<Object> get props => [data];
}
