import 'package:core/presentation/bloc/cubit/tv_list_popular_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

class TvPopular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Tv Series')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvListPopularCubit, TvListPopularState>(
          builder: (context, state) {
            if (state is TvListPopularLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TvListPopularLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.data[index];
                  return TvCardList(tv);
                },
                itemCount: state.data.length,
              );
            } else if (state is TvListPopularError) {
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
