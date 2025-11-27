import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/cubit/popular_movie_cubit.dart';
import '../widgets/movie_card_list.dart';
import 'package:flutter/material.dart';


class PopularMoviesPage extends StatefulWidget {
  
  
  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<PopularMovieCubit>().getPopularMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieCubit,PopularMovieState>(
          builder: (context, state) {
            if (state is PopularMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMovieLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.data[index];
                  return MovieCard(movie);
                },
                itemCount: state.data.length,
              );
            } else if(state is PopularMovieError){
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            }else{
              return Container();
            }
          },
        ),
      ),
    );
  }
}
