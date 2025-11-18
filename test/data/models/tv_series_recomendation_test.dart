import 'dart:convert';

import 'package:ditonton/data/models/tv_series_detail_recomendation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main(){
  test("model should returnn model and result should return list", (){
    final data = TvSeriesDetailRecomendation.fromJson(jsonDecode(readJson("dummy_data/recomendationDetail.json")));
    expect(data.results, isA<List<TvSeriesDetailRecomendationItem>>());
    expect(data, isA<TvSeriesDetailRecomendation>());
  });
  
}