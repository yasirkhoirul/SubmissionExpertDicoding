import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_popular_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvPopular extends StatelessWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvPopularNotifier>(
          builder: (context, data, child) {
            if (data.status == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.status == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.dataPopular[index];
                  return TvCardList(tv);
                },
                itemCount: data.dataPopular.length,
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
