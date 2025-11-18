import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/usecases/watchlisttvseries/search_watchlistv.dart';
import 'package:flutter/material.dart';

class TvSearchNotifier extends ChangeNotifier {
  String _message = "";
  String get message => _message;

  List<TvseriesEntity>? _data;
  List<TvseriesEntity>? get data => _data;

  RequestState _status = RequestState.Empty;
  RequestState get status => _status;

  TvSearchNotifier({required this.searchWatchlistTv});
  final SearchWatchlistTv searchWatchlistTv;

  searchtv(String search) async {
    _status = RequestState.Loading;
    notifyListeners();
    try {
      final responses = await searchWatchlistTv.excute(search);
      responses.fold(
        (l) {
          _status = RequestState.Error;
          _message = l.message;
        },
        (r) {
          _status = RequestState.Loaded;
          _data = r;
        },
      );
    } catch (e) {
      _status = RequestState.Error;
      _message = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
