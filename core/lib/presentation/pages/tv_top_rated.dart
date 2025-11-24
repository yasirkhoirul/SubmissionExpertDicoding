import '../../utils/state_enum.dart';
import '../provider/tv_top_rated_notifier.dart';
import '../widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvTopRated extends StatelessWidget {
  
  const TvTopRated();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvTopRatedNotifier>(
          builder: (context, data, child) {
            if (data.status == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.status == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.dataTopRated[index];
                  return TvCardList(tv);
                },
                itemCount: data.dataTopRated.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
