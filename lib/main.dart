
import 'package:about/about.dart';
import 'package:core/presentation/bloc/cubit/get_recomedation_detail_tv_cubit.dart';
import 'package:core/presentation/bloc/cubit/tv_list_cubit.dart';
import 'package:core/presentation/bloc/cubit/tv_list_popular_cubit.dart';
import 'package:core/presentation/bloc/cubit/tv_list_top_rated_cubit.dart';
import 'package:core/presentation/bloc/get_detail_tv_series/bloc/get_detail_tv_series_bloc.dart';
import 'package:core/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:core/presentation/bloc/search_tv_bloc/bloc/search_tv_bloc.dart';
import 'package:core/style/colors.dart';
import 'package:core/style/textstyle.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/cubit/list_movie_cubit.dart';
import 'package:movie/presentation/cubit/movie_detail_cubit.dart';
import 'package:movie/presentation/cubit/popular_movie_cubit.dart';
import 'package:movie/presentation/cubit/top_rated_movie_cubit.dart';
import 'package:movie/presentation/cubit/watchlist_movie_cubit.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tv_popular.dart';
import 'package:core/presentation/pages/tv_series_detail_page.dart';
import 'package:core/presentation/pages/tv_top_rated.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3. Setup Crashlytics (Agar error Flutter tertangkap otomatis)
  // Menangkap error "fatal" (yang bikin aplikasi keluar)
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<MovieListNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<MovieDetailNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<MovieSearchNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<TopRatedMoviesNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<PopularMoviesNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (_) => di.locator<WatchlistMovieNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => di.locator<TvListNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => di.locator<TvSeriesDetailNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => di.locator<WatchlistTvNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => di.locator<TvSearchNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => di.locator<TvTopRatedNotifier>(),
        // ),
        // ChangeNotifierProvider(
        //   create: (context) => di.locator<TvPopularNotifier>(),
        // ),
        BlocProvider(
          create: (context) => di.locator<SearchBloc>(),
        ),
        BlocProvider(create: (context) => di.locator<SearchTvBloc>(),),
        BlocProvider(create: (context) => di.locator<GetRecomedationDetailTvCubit>(),),
        BlocProvider(create: (context) => di.locator<GetDetailTvSeriesBloc>(),),
        BlocProvider(create: (context) => di.locator<TvListCubit>(),),
        BlocProvider(create: (context) => di.locator<TvListTopRatedCubit>(),),
        BlocProvider(create: (context) => di.locator<TvListPopularCubit>(),),
        BlocProvider(create: (context) => di.locator<MovieDetailCubit>(),),
        BlocProvider(create: (context) => di.locator<PopularMovieCubit>(),),
        BlocProvider(create: (context) => di.locator<TopRatedMovieCubit>(),),
        BlocProvider(create: (context) => di.locator<WatchlistMovieCubit>(),),
        BlocProvider(create: (context) => di.locator<ListMovieCubit>(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case routePopularMovie:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case routeTopRatedMovie:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case routeDetail:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case routeSearch:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case routeWatchlistMovie:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case routeAbout:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case routeTvDetail:
              final id = settings.arguments as double;
              return MaterialPageRoute(
                builder: (context) => TvSeriesDetailPage(id),
              );
            case routeTopRatedTv:
              return MaterialPageRoute(
                builder: (context) => TvTopRated(),
              );
            case routePopularTv:
              return MaterialPageRoute(
                builder: (context) => TvPopular(),
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
