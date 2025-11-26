import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/cubit/tv_list_cubit.dart';
import 'package:core/presentation/bloc/cubit/tv_list_popular_cubit.dart';
import 'package:core/presentation/bloc/cubit/tv_list_top_rated_cubit.dart';
import 'package:core/utils/routes.dart';
import 'package:core/style/textstyle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie.dart';
import '../../domain/entities/tvseries.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import '../../utils/state_enum.dart';
import '../provider/tv_list_notifier.dart';
import '../provider/tv_popular_notifier.dart';
import '../provider/tv_top_rated_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {

  const HomeMoviePage({super.key});
  
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies();

      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          context.read<TvListCubit>().getListTv();
          context.read<TvListPopularCubit>().getPopularTvList();
          context.read<TvListTopRatedCubit>().getToprated();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, routeWatchlistMovie);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, routeAbout);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, routeSearch);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildheadingMovie(),
                  Text(
                    'Now Playing',
                    style: kHeading6,
                  ),
                ],
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.nowPlayingMovies);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, routePopularMovie),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.popularMoviesState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.popularMovies);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, routeTopRatedMovie),
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.topRatedMoviesState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.topRatedMovies);
                } else {
                  return Text('Failed');
                }
              }),
              buildHeadingTv(),
              BlocBuilder<TvListCubit,TvListState>(
                builder: (context, state) {
                  if (state is TvListLoaded) {
                    return TvOnAiring(
                      data: state.data,
                    );
                  } else if (state is TvListLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Text("failed");
                  }
                },
              ),
              _buildSubHeading(
                  title: "Top Rated",
                  onTap: () {
                    Navigator.pushNamed(context, routeTopRatedTv);
                  }),
              BlocBuilder<TvListTopRatedCubit,TvListTopRatedState>(
                builder: (context, state) {
                  if (state is TvListTopRatedLoaded) {
                    return TvOnAiring(
                      data: state.data,
                    );
                  } else if (state is TvListTopRatedError) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Text("failed");
                  }
                },
              ),
              _buildSubHeading(
                  title: "Popular",
                  onTap: () {
                    Navigator.pushNamed(context, routePopularTv);
                  }),
               BlocBuilder<TvListPopularCubit,TvListPopularState>(
                builder: (context, state) {
                  if (state is TvListPopularLoaded) {
                    return TvOnAiring(
                      data: state.data,
                    );
                  } else if (state is TvListPopularLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Text("failed");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildHeadingTv() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.tv),
            SizedBox(
              width: 10,
            ),
            Text(
              "TV SERIES",
              style: kHeading6,
            ),
          ],
        ),
        Text(
          "On Airing",
          style: kHeading6,
        )
      ],
    );
  }

  Row buildheadingMovie() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.movie),
        SizedBox(
          width: 10,
        ),
        Text(
          "Movie",
          style: kHeading6,
        )
      ],
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvOnAiring extends StatelessWidget {
  const TvOnAiring({
    required this.data,
    super.key
  });

  final List<TvseriesEntity> data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routeTvDetail,
                  arguments: data[index].id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${data[index].poster_path}',
                  placeholder: (context, url) => Center(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies,{super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  routeDetail,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
