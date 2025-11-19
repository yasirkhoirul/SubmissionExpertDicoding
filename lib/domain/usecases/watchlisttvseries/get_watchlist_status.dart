import 'package:ditonton/domain/repositories/tv_repositories.dart';

class GetWatchlistStatusTv {
  final TvRepositories tvrepo;
  GetWatchlistStatusTv({required this.tvrepo});

  Future<bool> execute(int id) {
    return tvrepo.isAddedToWatchlist(id);
  }
}
