import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/tv_series_detail_recomendation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  final apikey = "2174d146bb9c0eab47529b2e77d6b526";
  final baseurl = "api.themoviedb.org";
  final basepath = "/3/tv";
  late TvSeriesRemoteDataSourceImpl tvSeriesRemoteDataSourceImpl;
  late MockHttpClient mockHttpClient;
  setUp(
    () {
      mockHttpClient = MockHttpClient();
      tvSeriesRemoteDataSourceImpl =
          TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
    },
  );
  group("test api list tv series", () {
    final fakejson = readJson('dummy_data/tv_series_on_airing.json');
    final fakejsonTopRated = readJson('dummy_data/tv_top_rated.json');
    final fakejsonpopular = readJson('dummy_data/tv_popular.json');
    final fakemodel = TvResponse.fromJson(jsonDecode(fakejson));
    final fakemodeltoprated = TvResponse.fromJson(jsonDecode(fakejsonTopRated));
    final fakemodelpopular = TvResponse.fromJson(jsonDecode(fakejsonpopular));
    test("should return model tv", () async {
      //arrange
      final uri =
          Uri.https(baseurl, "$basepath/on_the_air", {"api_key": apikey});
      when(mockHttpClient.get(uri)).thenAnswer(
        (realInvocation) async => http.Response(fakejson, 200),
      );
      //act
      final result = await tvSeriesRemoteDataSourceImpl.getTvSeriesOnAiring();

      //assert
      expect(result, equals(fakemodel));
    });

    test("test top rated should return respond top rated", ()async{
      final uris =
          Uri.https(baseurl, "$basepath/top_rated", {"api_key": apikey});
      when(mockHttpClient.get(uris)).thenAnswer(
        (realInvocation) async => http.Response(fakejsonTopRated, 200),
      );

      final result  = await tvSeriesRemoteDataSourceImpl.getTopRated();

      expect(result, fakemodeltoprated);
    });

    test("test Popular should return respond popular", ()async{
      final uris =
          Uri.https(baseurl, "$basepath/popular", {"api_key": apikey});
      when(mockHttpClient.get(uris)).thenAnswer(
        (realInvocation) async => http.Response(fakejsonpopular, 200),
      );

      final result  = await tvSeriesRemoteDataSourceImpl.getPopular();

      expect(result, fakemodelpopular);
    });

    test("should return exception if status code other than 200", () async {
      //arrange
      final uri =
          Uri.https(baseurl, "$basepath/on_the_air", {"api_key": apikey});
      when(mockHttpClient.get(uri)).thenAnswer(
        (realInvocation) async => http.Response("not found", 404),
      );
      //act
      final respone = tvSeriesRemoteDataSourceImpl.getTvSeriesOnAiring();

      //assert
      expect(() async => await respone, throwsA(isA<ServerException>()));
    });
  });

  group(
    "get detail tv test api",
    () {
      print("lalalalala");
      final fakejsons = readJson("dummy_data/tv_series_detail.json");
      print(jsonDecode(fakejsons));
      final datadetail = TvDetailModel.fromJson(jsonDecode(fakejsons));
      final seriesid = 200875;
      final uri =
          Uri.https(baseurl, "$basepath/$seriesid", {"api_key": apikey});
      test("if status code 200 should return tv model", () async {
        //arrange
        when(mockHttpClient.get(uri)).thenAnswer(
          (realInvocation) async => http.Response(fakejsons, 200),
        );
        //act
        final response = await tvSeriesRemoteDataSourceImpl.getTvDetail(200875);
        //assert
        expect(response, equals(datadetail));
      });
      test("if status code other than 200 should throw tv server Exception",
          () async {
        //arrange
        when(mockHttpClient.get(uri)).thenAnswer(
          (realInvocation) async => http.Response("Not Found", 404),
        );
        //act
        //assert
        expect(() async => await tvSeriesRemoteDataSourceImpl.getTvDetail(200875), throwsA(isA<ServerException>()));
      });
    },
  );

  group("testing search and rekomen", (){
    final id = 1;
    final qury = "Demon";
    final fakejson = readJson('dummy_data/tv_series_on_airing.json');
    
    final fakemodel = TvResponse.fromJson(jsonDecode(fakejson));
    
    final uri = Uri.https(baseurl,"/3/search/tv",{"api_key":apikey,"query":"Demon"});
    final urirekomen = Uri.https(baseurl,"$basepath/$id/recommendations",{"api_key":apikey});
    test("should return list search", ()async{
      //arrange 
      when(mockHttpClient.get(uri)).thenAnswer((realInvocation) async => http.Response(fakejson, 200),);

      //act
      final result = await tvSeriesRemoteDataSourceImpl.searchtv(qury);
      //
      expect(result, fakemodel);
    });

    test("should return recomendation Tv", ()async{
      
      when(mockHttpClient.get(urirekomen)).thenAnswer((realInvocation) async => http.Response(fakejson,200) ,);

      final result = await tvSeriesRemoteDataSourceImpl.getRecomendation(id);
      expect(result, TvSeriesDetailRecomendation.fromJson(jsonDecode(fakejson)));
    });
  });


  
}
