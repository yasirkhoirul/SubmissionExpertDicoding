import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tvseries.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: "TypeMovie.Movie"
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: TypeMovie.Movie
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final listTvEntity = [
  TvseriesEntity(
      false,
      "/2fOKVDoc2O3eZmBZesWPuE5kgPN.jpg",
      [18, 9648],
      200875,
      ["US"],
      "en",
      "IT: Welcome to Derry",
      "In 1962, a couple with their son move to Derry, Maine just as a young boy disappears. With their arrival, very bad things begin to happen in the town.",
      316.4234,
      "/nyy3BITeIjviv6PFIXtqvc8i6xi.jpg",
      "2025-10-26",
      "IT: Welcome to Derry",
      7.922,
      351)
];

final dummyResonse = TvResponse(1, [dummyTVMOdel]);
final dummyTVMOdel = TvModel(
    false,
    "/2fOKVDoc2O3eZmBZesWPuE5kgPN.jpg",
    [18, 9648],
    200875,
    ["US"],
    "en",
    "IT: Welcome to Derry",
    "In 1962, a couple with their son move to Derry, Maine just as a young boy disappears. With their arrival, very bad things begin to happen in the town.",
    316.4234,
    "/nyy3BITeIjviv6PFIXtqvc8i6xi.jpg",
    "2025-10-26",
    "IT: Welcome to Derry",
    7.922,
    351);
final last_episode_to_airdummy = Episode(
    6548352,
    "Now You See It",
    "As Leroy, Pauly, and Dick search for a new dig site, the kids attempt to get visual proof of the phenomena they've been experiencing.",
    4.886,
    22,
    "2025-11-09",
    3,
    "standard",
    "",
    59,
    1,
    200875,
    "/n4BGtiqwoFYd5ZX3UmdupeENcq.jpg");
final next_episode_to_airdummy = Episode(
    6548353,
    "The Great Swirling Apparatus of Our Planet's Function",
    "After their efforts are rejected by Chief Bowers, the kids must deal with their disappointment...and a series of increasingly terrifying experiences. Meanwhile, as General Shaw escalates his efforts to find answers, Charlotte tries to advocate for a reluctant Hank, who worries his secret will get out. Urged on by the Patty Cakes, Marge pulls a mean-spirited prank on Lilly.",
    0.0,
    0,
    "2025-11-16",
    4,
    "standard",
    "",
    66,
    1,
    200875,
    null);
final Network networkdummy =
    Network(49, "/tuomPhY2UtuPTqqFnKMVHvSb724.png", "HBO", "US");
final Production_companies pcompaniesdummy = Production_companies(
    1957, "/pJJw98MtNFC9cHn3o15G7vaUnnX.png", "Warner Bros. Television", "US");
final Production_countries pcountrydummy =
    Production_countries("US", "United States of America");
final seasonsdummy = Season("2025-10-26", 8, 291792, "Season 1", "",
    "/IFi0kbnVAoEVReaBuhOSj6GBMH.jpg", 1, 5.7);
final Spoken_languages spoken_languagesdummy =
    Spoken_languages("English", "en", "English");
final CreatedBy createdBydummy = CreatedBy(
    1113116,
    "682cac47989cf65c7edb32d8",
    "Andy Muschietti",
    "Andy Muschietti",
    2,
    "/4ndnP2NNavhfGtJqihD4FVDsYMY.jpg");
final dummydetail = TvDetailModel(
    false,
    "/2fOKVDoc2O3eZmBZesWPuE5kgPN.jpg",
    [createdBydummy],
    [],
    "2025-10-26",
    <GenreModel>[
      GenreModel(id: 18, name: "Drama"),
      GenreModel(id: 9648, name: "Mystery")
    ],
    "https://www.hbo.com/content/it-welcome-to-derry",
    200875,
    true,
    ["en"],
    "2025-11-09",
    last_episode_to_airdummy,
    "IT: Welcome to Derry",
    next_episode_to_airdummy,
    <Network>[networkdummy],
    8,
    1,
    ["US"],
    "en",
    "IT: Welcome to Derry",
    "In 1962, a couple with their son move to Derry, Maine just as a young boy disappears. With their arrival, very bad things begin to happen in the town.",
    296.413,
    "/nyy3BITeIjviv6PFIXtqvc8i6xi.jpg",
    [pcompaniesdummy],
    [pcountrydummy],
    [seasonsdummy],
    [spoken_languagesdummy],
    "Returning Series",
    "Go back to where IT all began.",
    "Scripted",
    7.891,
    361);
