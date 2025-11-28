
import 'package:core/data/datasources/tv_loacl_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';
import 'package:core/domain/repositories/tv_repositories.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  TvSeriesRemoteDataSource,
  TvLoaclDataSource,
  TvRepositories
])
void main(){

}