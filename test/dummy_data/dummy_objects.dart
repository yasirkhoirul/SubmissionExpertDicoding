import 'package:ditonton/data/models/movie_table.dart';
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
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
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

final dummyTVMOdel = TvModel(false,
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

final dummyResonse = TvResponse(1, [dummyTVMOdel]);
