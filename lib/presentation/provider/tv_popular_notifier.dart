import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_popular_tv.dart';
import 'package:flutter/foundation.dart';

class TvPopularNotifier extends ChangeNotifier {
  RequestState _status = RequestState.Empty;
  RequestState get status => _status;

  List<TvseriesEntity> _dataPopular = <TvseriesEntity>[];
  List<TvseriesEntity> get dataPopular => _dataPopular;

  String _message = '';
  String get message => _message;
  TvPopularNotifier({required this.getPopularTv});
  final GetPopularTv getPopularTv;

  getPopular() async {
    _status = RequestState.Loading;
    notifyListeners();
    try {
      final result = await getPopularTv.execute();
      result.fold(
        (l) {
          _status = RequestState.Error;
          _message = l.message;
        },
        (r) {
          _status = RequestState.Loaded;
          _dataPopular = r;
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
