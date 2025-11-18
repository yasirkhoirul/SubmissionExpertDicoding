import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';

class GetTvSeriesDetail {
  GetTvSeriesDetail(this.tvrepo);
  final TvRepositories tvrepo;
  

  Future<Either<Failure,TvSeriesDetail>> execute(int id){
    return tvrepo.getDetail(id);
  }
}