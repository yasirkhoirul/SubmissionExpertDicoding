
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/get_tv_on_airing.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  RequestState _status = RequestState.Empty;
  RequestState get status => _status;

  List<TvseriesEntity> _dataTvOnAiring = <TvseriesEntity>[];
  List<TvseriesEntity> get dataTvSeriesOnAiring => _dataTvOnAiring;

  String _message = '';
  String get message => _message;
  TvListNotifier({required this.getTvOnAiring});
  final GetTvOnAiring getTvOnAiring;

  Future getListTvOnAiring() async {
    _status = RequestState.Loading;
    notifyListeners();
    try {
      final result = await getTvOnAiring.execute();
      result.fold(
        (l) {
          _status = RequestState.Error;
          _message = l.message;
        },
        (r) {
          _status = RequestState.Loaded;
          _dataTvOnAiring = r;
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
