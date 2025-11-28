import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_list_popular_state.dart';

class TvListPopularCubit extends Cubit<TvListPopularState> {
  final GetPopularTv getPopularTv;
  TvListPopularCubit({required this.getPopularTv})
    : super(TvListPopularInitial());

  void getPopularTvList() async {
    emit(TvListPopularLoading());
    final data = await getPopularTv.execute();
    data.fold(
      (l) {
        emit(TvListPopularError(l.message));
      },
      (r) {
        emit(TvListPopularLoaded(r));
      },
    );
  }
}
