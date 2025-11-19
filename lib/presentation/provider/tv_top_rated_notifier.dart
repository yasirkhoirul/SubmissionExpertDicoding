import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/foundation.dart';

class TvTopRatedNotifier extends ChangeNotifier {
  RequestState _status = RequestState.Empty;
  RequestState get status => _status;

  List<TvseriesEntity> _dataTopRated = <TvseriesEntity>[];
  List<TvseriesEntity> get dataTopRated => _dataTopRated;

  String _message = '';
  String get message => _message;
  TvTopRatedNotifier({required this.getTopRatedTv});
  final GetTopRatedTv getTopRatedTv;

  getToprated() async {
    _status = RequestState.Loading;
    notifyListeners();
    try {
      final result = await getTopRatedTv.execute();
      result.fold(
        (l) {
          _status = RequestState.Error;
          _message = l.message;
        },
        (r) {
          _status = RequestState.Loaded;
          _dataTopRated = r;
        },
      );
    } catch (e) {
      _message = e.toString();
      _status = RequestState.Error;
    } finally {
      notifyListeners();
    }
  }
}
