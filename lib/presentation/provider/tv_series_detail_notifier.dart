import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/tv_series_recomendation.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recomendation.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/watchlisttvseries/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/watchlisttvseries/save_watchlist_tv.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/web.dart';

class TvSeriesDetailNotifier extends ChangeNotifier{

  RequestState _statusRekomendation = RequestState.Empty;
  RequestState get statusrecomendation => _statusRekomendation;

  RequestState _status = RequestState.Empty;
  RequestState get status => _status;

  RequestState _statusWatchlist = RequestState.Empty;
  RequestState get statuswatchlist =>  _statusWatchlist;

  TvSeriesDetail? _datadetail;
  TvSeriesDetail? get datadetail => _datadetail;

  List<TvSeriesRecomendationitem>? _datarekomendasi;
  List<TvSeriesRecomendationitem>? get datarekomendasi => _datarekomendasi;

  String _messageRek ="";
  String get messagerek => _messageRek;

  String _message = "";
  String get message => _message;

  String _watchlistmessage ="";
  String get watchlistmessage => _watchlistmessage;

  bool _isAddedToWatchlist = false;
  bool get isAddedWatchlist => _isAddedToWatchlist;

  TvSeriesDetailNotifier( {required this.getMovieDetail,required this.getTvSeriesRecomendation,required this.saveWatchlistTv,required this.getWatchListStatus,required this.removeWatchlistTv});
  final GetTvSeriesDetail getMovieDetail;
  final GetTvSeriesRecomendation getTvSeriesRecomendation;
  final SaveWatchlistTv saveWatchlistTv;
  final GetWatchListStatus getWatchListStatus;
  final RemoveWatchlistTv removeWatchlistTv;

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }

  Future<void> addWatchlist(TvSeriesDetail tv) async {

    Logger().d("ini akan ditambahkan $tv");
    final result = await saveWatchlistTv.execute(tv);
    Logger().d("hasilnya $result");

    await result.fold(
      (failure) async {
        _watchlistmessage = failure.message;
      },
      (successMessage) async {
        _watchlistmessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  getDetail(int id) async{
    _status = RequestState.Loading;
    notifyListeners();
    try {
      final data = await getMovieDetail.execute(id);
      data.fold(
        (l) {
          _status = RequestState.Error;
          _message = l.message;
        }
        , 
        (r) {
          _status = RequestState.Loaded;
          _datadetail = r;
        },
        );
    } catch (e) {
      _status = RequestState.Error;
      _message = e.toString();
    } finally{
      notifyListeners();
    }
  }

  getRecomendation(int id)async{
    _statusRekomendation = RequestState.Loading;
    notifyListeners();
    try {
      Logger().d("masuk try");
      final data = await getTvSeriesRecomendation.execute(id);
      data.fold(
        (l) {
          _statusRekomendation = RequestState.Error;
          _messageRek = l.message;
        }
        , (r) {
          _statusRekomendation = RequestState.Loaded;
          _datarekomendasi = r;
          
        },);
    } catch (e) {
      _statusRekomendation = RequestState.Error;
      _message = e.toString();
    }finally{
      notifyListeners();
    }
  }

  removeWatchLIst(TvSeriesDetail tv)async{    
    Logger().d("yang akan dihapus ${tv.id}");
    final result = await removeWatchlistTv.excute(tv);

    result.fold(
      (l) {
        _statusWatchlist = RequestState.Error;
        _watchlistmessage = l.message;
        notifyListeners();
      }
      , (r) {
        _statusWatchlist = RequestState.Loaded;
        _watchlistmessage = r;
        notifyListeners();
      },);
      await loadWatchlistStatus(tv.id);
  }
}