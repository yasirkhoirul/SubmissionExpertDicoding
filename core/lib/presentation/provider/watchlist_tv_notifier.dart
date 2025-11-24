import '../../utils/state_enum.dart';
import '../../domain/entities/tvseries.dart';
import '../../domain/usecases/watchlisttvseries/get_watchlist_status.dart';
import '../../domain/usecases/watchlisttvseries/get_watchlist_tv.dart';
import '../../domain/usecases/watchlisttvseries/remove_watchlist_tv.dart';
import '../../domain/usecases/watchlisttvseries/save_watchlist_tv.dart';
import 'package:flutter/material.dart';

class WatchlistTvNotifier extends ChangeNotifier {
  RequestState _status = RequestState.Empty;
  RequestState get status => _status;

  List<TvseriesEntity>? _data;
  List<TvseriesEntity>? get data => _data;

  String _message = '';
  String get message => _message;

  WatchlistTvNotifier(
      {required this.statusTv,
      required this.getWatchlistTv,
      required this.removeWatchlistTv,
      required this.saveWatchlistTv});
  final GetWatchlistStatusTv statusTv;
  final GetWatchlistTv getWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;
  final SaveWatchlistTv saveWatchlistTv;

  addtvwatchlist() async {
    _status = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _status = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _status = RequestState.Loaded;
        _data = moviesData;
        notifyListeners();
      },
    );
  }
}
