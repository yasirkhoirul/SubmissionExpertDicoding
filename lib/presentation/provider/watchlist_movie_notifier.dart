import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class WatchlistMovieNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistMovieNotifier({required this.getWatchlistMovies});

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();
    try {
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) {
          _watchlistState = RequestState.Error;
          _message = failure.message;
          notifyListeners();
        },
        (moviesData) {
          _watchlistState = RequestState.Loaded;
          Logger().d("ini adalah list dari watchlist $moviesData");
          _watchlistMovies = moviesData;
          notifyListeners();
        },
      );
    } catch (e) {
      Logger().d("ini adalah error list dari watchlist $e");
    }
  }
}
