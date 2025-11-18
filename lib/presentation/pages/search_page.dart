import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late PageController pageController;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
                context.read<TvSearchNotifier>().searchtv(query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      child: Text("Movie", textAlign: TextAlign.center),
                      onPressed: () {
                        pageController.jumpToPage(
                          0,
                        );
                      },
                    )),
                    Expanded(
                        child: TextButton(
                      child: Text("Tv Series", textAlign: TextAlign.center),
                      onPressed: () {
                        pageController.jumpToPage(
                          1,
                        );
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 2,
                          effect: WormEffect(
                              
                              dotWidth: MediaQuery.of(context).size.width * 0.45,
                              dotHeight: 4),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  Consumer<MovieSearchNotifier>(
                    builder: (context, data, child) {
                      if (data.state == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.state == RequestState.Loaded) {
                        final result = data.searchResult;
                        return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemBuilder: (context, index) {
                            final movie = data.searchResult[index];
                            if (index == 0) {
                              return Column(
                                children: [Text("Movie"), MovieCard(movie)],
                              );
                            } else {
                              return MovieCard(movie);
                            }
                          },
                          itemCount: result.length,
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  ),
                  Consumer<TvSearchNotifier>(
                    builder: (context,values,child) {
                      Logger().d(values.status);
                      if (values.status == RequestState.Loading) {
                        return Center(child:  CircularProgressIndicator(),);
                      }else if(values.status == RequestState.Loaded){
                        return ListView.builder(
                        itemCount: values.data!.length,
                        itemBuilder: (context, index) => TvCardList(values.data![index]),
                      );
                      }else if(values.status == RequestState.Error){
                        return Center(child: Text(values.message),);
                      }else{
                        return Container();
                      }
                    }
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
