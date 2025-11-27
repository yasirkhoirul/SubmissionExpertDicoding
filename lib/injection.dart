import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/presentation/bloc/cubit/get_recomedation_detail_tv_cubit.dart';
import 'package:core/presentation/bloc/cubit/tv_list_cubit.dart';
import 'package:core/presentation/bloc/cubit/tv_list_popular_cubit.dart';
import 'package:core/presentation/bloc/cubit/tv_list_top_rated_cubit.dart';
import 'package:core/presentation/bloc/get_detail_tv_series/bloc/get_detail_tv_series_bloc.dart';
import 'package:core/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:core/presentation/bloc/search_tv_bloc/bloc/search_tv_bloc.dart';
import 'package:core/utils/sslpinning.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_loacl_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repositories_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repositories.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:core/domain/usecases/get_tv_on_airing.dart';
import 'package:core/domain/usecases/get_tv_series_detail.dart';
import 'package:core/domain/usecases/get_tv_series_recomendation.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:core/domain/usecases/search_movies.dart';
import 'package:core/domain/usecases/watchlisttvseries/get_watchlist_status.dart';
import 'package:core/domain/usecases/watchlisttvseries/get_watchlist_tv.dart';
import 'package:core/domain/usecases/watchlisttvseries/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/watchlisttvseries/save_watchlist_tv.dart';
import 'package:core/domain/usecases/watchlisttvseries/search_watchlistv.dart';
import 'package:movie/presentation/cubit/movie_detail_cubit.dart';
import 'package:movie/presentation/cubit/popular_movie_cubit.dart';
import 'package:movie/presentation/cubit/top_rated_movie_cubit.dart';
import 'package:movie/presentation/cubit/watchlist_movie_cubit.dart';
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:core/presentation/provider/movie_search_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:core/presentation/provider/tv_list_notifier.dart';
import 'package:core/presentation/provider/tv_popular_notifier.dart';
import 'package:core/presentation/provider/tv_search_notifier.dart';
import 'package:core/presentation/provider/tv_series_detail_notifier.dart';
import 'package:core/presentation/provider/tv_top_rated_notifier.dart';
import 'package:movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:core/presentation/provider/watchlist_tv_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';


final locator = GetIt.instance;

Future<void> init() async{
  // provider
  locator.registerFactory(
    () => TvListNotifier(getTvOnAiring: locator()),
  );
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvPopularNotifier(getPopularTv: locator()),
  );
  locator.registerFactory(
    () => TvTopRatedNotifier(getTopRatedTv: locator<GetTopRatedTv>()),
  );

  locator.registerFactory(() => SearchBloc(searchMovies: locator<SearchMovies>()),);
  locator.registerFactory(() => SearchTvBloc(locator<SearchWatchlistTv>()),);
  locator.registerFactory(() => GetRecomedationDetailTvCubit(getTvSeriesRecomendation: locator()));
  locator.registerFactory(() => GetDetailTvSeriesBloc(locator(),locator(),getWatchListStatus: locator(),removeWatchlistTv: locator()));
  locator.registerFactory(() => TvListCubit(getWatchlistTv: locator()),);
  locator.registerFactory(() => TvListPopularCubit(getPopularTv: locator()),);
  locator.registerFactory(() => TvListTopRatedCubit(getTopRatedTv: locator()),);
  locator.registerFactory(() => MovieDetailCubit(locator(), locator(), locator(), locator(), locator()));

  locator.registerFactory(
    () => TvSeriesDetailNotifier(
        getMovieDetail: locator(),
        getTvSeriesRecomendation: locator(),
        saveWatchlistTv: locator(),
        getWatchListStatus: locator(),
        removeWatchlistTv: locator()),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
        statusTv: locator(),
        getWatchlistTv: locator(),
        removeWatchlistTv: locator(),
        saveWatchlistTv: locator()),
  );
  locator.registerFactory(() => TvSearchNotifier(searchWatchlistTv: locator()));
  locator.registerFactory( () => PopularMovieCubit(locator()) );
  locator.registerFactory( () => TopRatedMovieCubit(locator()) );
  locator.registerFactory( () => WatchlistMovieCubit(locator()) );
  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(
    () => GetTvOnAiring(tvrepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetTvSeriesDetail(locator()),
  );
  locator.registerLazySingleton(
    () => GetTvSeriesRecomendation(locator()),
  );
  locator.registerLazySingleton(
    () => GetWatchlistTv(tvrepo: locator()),
  );
  locator.registerLazySingleton(
    () => RemoveWatchlistTv(tvrepo: locator()),
  );
  locator.registerLazySingleton(
    () => SaveWatchlistTv(tvrepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetWatchlistStatusTv(tvrepo: locator()),
  );
  locator.registerLazySingleton(() => SearchWatchlistTv(tvrepo: locator()));
  locator.registerLazySingleton(
    () => GetTopRatedTv(locator()),
  );
  locator.registerLazySingleton(
    () => GetPopularTv(locator()),
  );

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepositories>(
    () => TvRepositoriesImpl(
        tvdatasource: locator(), tvLoaclDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvLoaclDataSource>(
    () => TvLoaclDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  final sslClient = await getSSLPinningClient();
  locator.registerLazySingleton<http.Client>(() => sslClient);
}
