part of 'get_recomedation_detail_tv_cubit.dart';

sealed class GetRecomedationDetailTvState extends Equatable {
  const GetRecomedationDetailTvState();

  @override
  List<Object> get props => [];
}

final class GetRecomedationDetailTvInitial
    extends GetRecomedationDetailTvState {}

final class GetRecomendationDetailTvLoading
    extends GetRecomedationDetailTvState {}

final class GetRecomendationDetailTvError extends GetRecomedationDetailTvState {
  final String message;
  const GetRecomendationDetailTvError(this.message);

  @override
  List<Object> get props => [message];
}

final class GetRecomendationDetailTvLoaded
    extends GetRecomedationDetailTvState {
  final List<TvSeriesRecomendationitem> data;
  const GetRecomendationDetailTvLoaded(this.data);

  @override
  List<Object> get props => [data];
}
