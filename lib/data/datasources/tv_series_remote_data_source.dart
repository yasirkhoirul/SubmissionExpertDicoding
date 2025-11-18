import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/tv_series_detail_recomendation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

abstract class TvSeriesRemoteDataSource {
  
  Future<TvResponse> getTvSeriesOnAiring();
  Future<TvDetailModel> getTvDetail(int id);
  Future<TvSeriesDetailRecomendation> getRecomendation(int id);
  Future<TvResponse> searchtv(String data);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {

  final http.Client client;
  TvSeriesRemoteDataSourceImpl({required this.client});
  final apikey = "2174d146bb9c0eab47529b2e77d6b526";
  final baseurl = "api.themoviedb.org";
  final basepath = "/3/tv";
  @override
  Future<TvResponse> getTvSeriesOnAiring() async {
    final uri = Uri.https(baseurl, "$basepath/on_the_air", {"api_key": apikey});
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<TvDetailModel> getTvDetail(int seriesid) async{
    final uri = Uri.https(baseurl,"$basepath/$seriesid",{"api_key": apikey});
    final respon = await client.get(uri);
    if(respon.statusCode == 200){
      return TvDetailModel.fromJson(jsonDecode(respon.body));
    }else{
      throw ServerException();
    }
  }
  
  @override
  Future<TvSeriesDetailRecomendation> getRecomendation(int id) async{
    final uri = Uri.https(baseurl,"$basepath/$id/recommendations",{"api_key":apikey});
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      return TvSeriesDetailRecomendation.fromJson(jsonDecode(response.body));
    }else{
      throw ServerException();
    }
  }

  Future<TvResponse> searchtv(String datasearch)async{
    final uri = Uri.https(baseurl,"/3/search/tv",{"api_key":apikey,"query":datasearch});
    final response = await client.get(uri);
    Logger().d("response dari search adalah ${response.body}");
    if (response.statusCode == 200) {
      return TvResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  


}
