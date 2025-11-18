
import 'dart:convert';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../json_reader.dart';

void main(){
  

group("Test Model TV Detail", (){
  final createdby = {
            "id": 1113116,
            "credit_id": "682cac47989cf65c7edb32d8",
            "name": "Andy Muschietti",
            "original_name": "Andy Muschietti",
            "gender": 2,
            "profile_path": "/4ndnP2NNavhfGtJqihD4FVDsYMY.jpg"
        };

  final genres = {
            "id": 18,
            "name": "Drama"
        };
  final last_episode_to_air = {
        "id": 6548353,
        "name": "The Great Swirling Apparatus of Our Planet's Function",
        "overview": "After their efforts are rejected by Chief Bowers, the kids must deal with their disappointment...and a series of increasingly terrifying experiences. Meanwhile, as General Shaw escalates his efforts to find answers, Charlotte tries to advocate for a reluctant Hank, who worries his secret will get out. Urged on by the Patty Cakes, Marge pulls a mean-spirited prank on Lilly.",
        "vote_average": 0.0,
        "vote_count": 0,
        "air_date": "2025-11-16",
        "episode_number": 4,
        "episode_type": "standard",
        "production_code": "",
        "runtime": 66,
        "season_number": 1,
        "show_id": 200875,
        "still_path": null
    };
  final network = {
            "id": 49,
            "logo_path": "/tuomPhY2UtuPTqqFnKMVHvSb724.png",
            "name": "HBO",
            "origin_country": "US"
        };
  final pcompany = {"id": 1957,
            "logo_path": "/pJJw98MtNFC9cHn3o15G7vaUnnX.png",
            "name": "Warner Bros. Television",
            "origin_country": "US"};

  final seasons = {
            "air_date": "2025-10-26",
            "episode_count": 8,
            "id": 291792,
            "name": "Season 1",
            "overview": "",
            "poster_path": "/IFi0kbnVAoEVReaBuhOSj6GBMH.jpg",
            "season_number": 1,
            "vote_average": 5.7
        };

        
test("should return model tv detail", (){
    final data = TvDetailModel.fromJson(jsonDecode(readJson("dummy_data/tv_series_detail.json")));
    expect(data, dummydetail);
  });
  test("should return model createdby", (){
    print(createdby);
    final data = CreatedBy.fromJson(createdby);
    expect(data, createdBydummy);
  });
  test("should return model genres", (){
    final data = GenreModel.fromJson(genres);
    expect(data, GenreModel(id: 18, name: "Drama"));
  });
  
  test("should return model Episode", (){
    final data = Episode.fromJson(last_episode_to_air);
    expect(data, next_episode_to_airdummy);
  });
  test("should return model Network", (){
    final data = Network.fromJson(network);
    expect(data, networkdummy);
  });
  test("should return model Production Company", (){
    final data = Production_companies.fromJson(pcompany);
    expect(data, pcompaniesdummy);
  });
  test("should return model Season", (){
    final data = Season.fromJson(seasons);
    expect(data, seasonsdummy);
  });
  
  
});
  


}