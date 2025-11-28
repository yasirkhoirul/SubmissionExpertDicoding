part of 'search_tv_bloc.dart';

sealed class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object> get props => [];
}

final class SearchTvInitial extends SearchTvState {}

final class SearchTvError extends SearchTvState {
  final String message;
  const SearchTvError(this.message);
}

final class SearchTvLoading extends SearchTvState {}

final class SearchTvLoaded extends SearchTvState {
  final List<TvseriesEntity> data;
  const SearchTvLoaded(this.data);

  @override
  List<Object> get props => [data];
}
