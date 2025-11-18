import 'dart:convert';

import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart' as dumy;
import '../../json_reader.dart';

void main() {
  group("test model", () {
    final tvrespone = dumy.dummyResonse;
    final fakejson = readJson('dummy_data/tv_series_on_airing.json');
    test("should return proper tv model", () {
      final fakemodel = TvResponse.fromJson(jsonDecode(fakejson));
      print(fakemodel);
      expect(tvrespone, fakemodel);
    });
  });
}
