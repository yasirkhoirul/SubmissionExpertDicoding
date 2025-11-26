import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/cubit/get_recomedation_detail_tv_cubit.dart';
import 'package:core/presentation/bloc/get_detail_tv_series/bloc/get_detail_tv_series_bloc.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../style/textstyle.dart';
import '../../style/colors.dart';
import '../../utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';

class TvSeriesDetailPage extends StatefulWidget {
  
  const TvSeriesDetailPage(this.id,{super.key});
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
        // context.read<TvSeriesDetailNotifier>().getDetail(widget.id.toInt());
        // context
        //     .read<TvSeriesDetailNotifier>()
        //     .getRecomendation(widget.id.toInt());
        context.read<GetDetailTvSeriesBloc>().add(OnDetailTvSeriesE(widget.id.toInt()));
        context.read<GetRecomedationDetailTvCubit>().getRecomendation(widget.id.toInt());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetDetailTvSeriesBloc,GetDetailTvSeriesState>(builder: (context, state) {
        if (state.tvseriesstatus == RequestState.Loading) {
          return SafeArea(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        } else if (state.tvseriesstatus == RequestState.Error) {
          return SafeArea(
              child: Center(
            child: Text("error ${state.detailmessage}"),
          ));
        } else if (state.tvseriesstatus == RequestState.Loaded) {
          final data = state.tvSeriesDetail;
          return SafeArea(
              child: Center(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: CachedNetworkImage(
                    width: MediaQuery.of(context).size.width,
                    imageUrl:
                        "https://image.tmdb.org/t/p/w500/${data!.poster_path}",
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
                                    data.name,
                                    style: kHeading5,
                                  ),
                                  FilledButton(
                                      onPressed: () {
                                        if (state.watchliststatus) {
                                          context.read<GetDetailTvSeriesBloc>().add(OnRemoveWatchListTv(data));
                                        } else {
                                          context.read<GetDetailTvSeriesBloc>().add(OnAddWatchListTv(data));
                                        }
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(state.watchliststatus
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
                                        rating: data.rating / 2,
                                      ),
                                      Text("${data.rating}")
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
                                      child: Text(data.overview)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Recomendation",
                                    style: kHeading5,
                                  ),
                                  BlocBuilder<GetRecomedationDetailTvCubit,GetRecomedationDetailTvState>(builder: (context, state) {
                                    if (state is GetRecomendationDetailTvLoading) {
                                      return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator()
                                          ],
                                        );
                                    }else if(state is GetRecomendationDetailTvError){
                                      return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(state.message)
                                          ],);
                                    }else if(state is GetRecomendationDetailTvLoaded){
                                      return SizedBox(
                                          height: 200,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  state.data.length,
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
                                                                    if (!context.mounted)return;
                                                                    Logger().d(
                                                                        "ditekan ${state.data[index].id}");
                                                                    Navigator.pushReplacementNamed(
                                                                        context,
                                                                        routeTvDetail,
                                                                        arguments: state.data[index]
                                                                            .id
                                                                            .toDouble());
                                                                  },
                                                                );
                                                              },
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    "$BASE_IMAGE_URL${state.data[index].path}",
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
                                        );
                                    }else{
                                      return Container();
                                    }
                                  },)

                                    
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
          return SizedBox(
            child: Center(
              child: Text("ada sesuatu yang salah silahkan kembali"),
            ),
          );
        }
      }),
    );
  }
}
