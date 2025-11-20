import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROOUTE_NAME = "/tv_detail";
  const TvSeriesDetailPage(this.id);
  final double id;

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (!context.mounted) return;
        Logger().d("memuat halaman dengan id ${widget.id}");
        context.read<TvSeriesDetailNotifier>().getDetail(widget.id.toInt());
        context
            .read<TvSeriesDetailNotifier>()
            .getRecomendation(widget.id.toInt());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(builder: (context, value, child) {
        if (value.status == RequestState.Loading) {
          return SafeArea(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        } else if (value.status == RequestState.Error) {
          return SafeArea(
              child: Center(
            child: Text("error ${value.message}"),
          ));
        } else if (value.status == RequestState.Loaded) {
          return SafeArea(
              child: Center(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width,
                    imageUrl:
                        "https://image.tmdb.org/t/p/w500/${value.datadetail!.poster_path}",
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.3,
                  maxChildSize: 0.85,
                  builder: (context, scrollController) => Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12)),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          controller: scrollController,
                          child: Container(
                            height: 800,
                            margin: EdgeInsets.only(top: 60),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                spacing: 10,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.datadetail!.name,
                                    style: kHeading5,
                                  ),
                                  FilledButton(
                                      onPressed: () {
                                        if (value.isAddedWatchlist) {
                                          value.removeWatchLIst(
                                              value.datadetail!);
                                        } else {
                                          value.addWatchlist(value.datadetail!);
                                        }
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(value.isAddedWatchlist
                                              ? Icons.check
                                              : Icons.add),
                                          Text("Add Wishlist")
                                        ],
                                      )),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        itemSize: 25,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: kMikadoYellow,
                                        ),
                                        itemCount: 5,
                                        rating: value.datadetail!.rating / 2,
                                      ),
                                      Text("${value.datadetail!.rating}")
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Overview",
                                    style: kHeading5,
                                  ),
                                  Expanded(
                                      child: Text(value.datadetail!.overview)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Recomendation",
                                    style: kHeading5,
                                  ),
                                  value.statusrecomendation ==
                                          RequestState.Loaded
                                      ? Container(
                                          height: 200,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  value.datarekomendasi!.length,
                                              itemBuilder:
                                                  (context, index) => ClipRRect(
                                                        borderRadius:
                                                            BorderRadiusGeometry
                                                                .circular(12),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: InkWell(
                                                              onTap: () {
                                                                WidgetsBinding
                                                                    .instance
                                                                    .addPostFrameCallback(
                                                                  (timeStamp) {
                                                                    if (!context
                                                                        .mounted)
                                                                      return;
                                                                    Logger().d(
                                                                        "ditekan ${value.datarekomendasi![index].id}");
                                                                    Navigator.pushReplacementNamed(
                                                                        context,
                                                                        TvSeriesDetailPage
                                                                            .ROOUTE_NAME,
                                                                        arguments: value
                                                                            .datarekomendasi![index]
                                                                            .id
                                                                            .toDouble());
                                                                  },
                                                                );
                                                              },
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    "$BASE_IMAGE_URL${value.datarekomendasi![index].path}",
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                                placeholder:
                                                                    (context,
                                                                            url) =>
                                                                        Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                ),
                                                              )),
                                                        ),
                                                      )),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator()
                                          ],
                                        )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              height: 5,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
        } else {
          return Container(
            child: Center(
              child: Text("ada sesuatu yang salah ${value.status}"),
            ),
          );
        }
      }),
    );
  }
}
