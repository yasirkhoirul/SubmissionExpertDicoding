
import 'package:about/about.dart';
import 'package:core/style/colors.dart';
import 'package:core/style/textstyle.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/utils.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tv_popular.dart';
import 'package:core/presentation/pages/tv_series_detail_page.dart';
import 'package:core/presentation/pages/tv_top_rated.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TvListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<WatchlistTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TvSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TvTopRatedNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (context) => di.locator<TvPopularNotifier>(),
        )
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
