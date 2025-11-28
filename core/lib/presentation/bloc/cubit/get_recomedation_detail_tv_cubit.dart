import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_series_recomendation.dart';
import 'package:core/domain/usecases/get_tv_series_recomendation.dart';
import 'package:equatable/equatable.dart';

part 'get_recomedation_detail_tv_state.dart';

class GetRecomedationDetailTvCubit extends Cubit<GetRecomedationDetailTvState> {
  final GetTvSeriesRecomendation getTvSeriesRecomendation;
  GetRecomedationDetailTvCubit({required this.getTvSeriesRecomendation})
    : super(GetRecomedationDetailTvInitial());

  void getRecomendation(int id) async {
    emit(GetRecomendationDetailTvLoading());
    final data = await getTvSeriesRecomendation.execute(id);

    data.fold(
      (l) {
        emit(GetRecomendationDetailTvError(l.message));
      },
      (r) {
        emit(GetRecomendationDetailTvLoaded(r));
      },
    );
  }
}
