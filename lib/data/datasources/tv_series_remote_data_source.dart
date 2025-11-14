import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteDataSource {
  
  Future<TvResponse> getTvSeriesOnAiring();
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
}
