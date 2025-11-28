import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_list_top_rated_state.dart';

class TvListTopRatedCubit extends Cubit<TvListTopRatedState> {
  final GetTopRatedTv getTopRatedTv;
  TvListTopRatedCubit({required this.getTopRatedTv})
    : super(TvListTopRatedInitial());

  void getToprated() async {
    emit(TvListTopRatedLoading());
    final data = await getTopRatedTv.execute();

    data.fold(
      (l) {
        emit(TvListTopRatedError(l.message));
      },
      (r) {
        emit(TvListTopRatedLoaded(r));
      },
    );
  }
}
