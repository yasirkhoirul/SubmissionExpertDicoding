part of 'tv_list_top_rated_cubit.dart';

sealed class TvListTopRatedState extends Equatable {
  const TvListTopRatedState();

  @override
  List<Object> get props => [];
}

final class TvListTopRatedInitial extends TvListTopRatedState {}

final class TvListTopRatedLoading extends TvListTopRatedState {}
final class TvListTopRatedError extends TvListTopRatedState {
  final String message;
  const TvListTopRatedError(this.message);

  @override
  
  List<Object> get props => [message];
}
final class TvListTopRatedLoaded extends TvListTopRatedState {

  final List<TvseriesEntity> data;
  const TvListTopRatedLoaded(this.data);

  @override
  
  List<Object> get props => [data];
}
