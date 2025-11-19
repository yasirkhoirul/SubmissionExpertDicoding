
import 'package:ditonton/data/datasources/tv_loacl_data_source.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/domain/repositories/tv_repositories.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  TvSeriesRemoteDataSource,
  TvLoaclDataSource,
  TvRepositories
])
void main(){

}