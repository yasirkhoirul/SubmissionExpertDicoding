import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/routes.dart';
import '../../style/textstyle.dart';
import '../../utils/state_enum.dart';
import '../../domain/entities/tvseries.dart';
import 'package:flutter/material.dart';

class TvCardList extends StatelessWidget {
  final TvseriesEntity movie;

  const TvCardList(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          if (movie.type == TypeMovie.Movie.toString()) {
            Navigator.pushNamed(context, routeDetail, arguments: movie.id);
          } else {
            Navigator.pushNamed(
              context,
              routeTvDetail,
              arguments: movie.id.toDouble(),
            );
          }
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.name ?? '-',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                    ),
                    SizedBox(height: 16),
                    Text(
                      movie.overview ?? '-',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),
                    Text(
                      movie.type == 'TypeMovie.Movie'
                          ? "Type : Movie"
                          : "Type : Tv",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.poster_path}',
                  width: 80,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
