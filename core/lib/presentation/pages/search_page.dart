import 'package:core/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:core/presentation/bloc/search_tv_bloc/bloc/search_tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../style/textstyle.dart';
import '../widgets/movie_card_list.dart';
import '../widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
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
      appBar: AppBar(title: Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchBloc>().add(OnQueryChanged(query));
                context.read<SearchTvBloc>().add(OnSearchTvQuery(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text('Search Result', style: kHeading6),
            SizedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text("Movie", textAlign: TextAlign.center),
                          onPressed: () {
                            pageController.jumpToPage(0);
                          },
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          child: Text("Tv Series", textAlign: TextAlign.center),
                          onPressed: () {
                            pageController.jumpToPage(1);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
                              dotWidth:
                                  MediaQuery.of(context).size.width * 0.45,
                              dotHeight: 4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                child: PageView(
                  controller: pageController,
                  children: [
                    BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is SearchLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is SearchHasData) {
                          final result = state.data;
                          return ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = state.data[index];
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
                        } else if (state is SearchError) {
                          return SizedBox(
                            child: Center(child: Text(state.message)),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    BlocBuilder<SearchTvBloc, SearchTvState>(
                      builder: (context, state) {
                        if (state is SearchTvLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is SearchTvLoaded) {
                          final dataTv = state.data;
                          return ListView.builder(
                            itemCount: dataTv.length,
                            itemBuilder: (context, index) =>
                                TvCardList(dataTv[index]),
                          );
                        } else if (state is SearchTvError) {
                          return Center(child: Text(state.message));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
