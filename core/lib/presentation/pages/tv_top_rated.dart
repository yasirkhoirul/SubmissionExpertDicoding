import 'package:core/presentation/bloc/cubit/tv_list_top_rated_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class TvTopRated extends StatelessWidget {
  const TvTopRated();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Rated Tv Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvListTopRatedCubit, TvListTopRatedState>(
          builder: (context, state) {
            if (state is TvListTopRatedLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TvListTopRatedLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.data[index];
                  return TvCardList(tv);
                },
                itemCount: state.data.length,
              );
            } else if (state is TvListTopRatedError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
