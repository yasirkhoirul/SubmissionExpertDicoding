import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/data/datasources/tv_loacl_data_source.dart';
import 'package:ditonton/data/models/tv_series_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
void main(){
  late MockDatabaseHelper databaseHelper;
  late TvLoaclDataSourceImpl dataSource;
  setUp(
    () {
      databaseHelper = MockDatabaseHelper();
      dataSource = TvLoaclDataSourceImpl(databaseHelper: databaseHelper);
    },
  );

  final TvSeriesTable dummy_data = TvSeriesTable(1, "title", "posterPath", "overview", TypeMovie.TvSeries);
  group("test database", (){
    test("should return message succes when insert database", ()async{
      //arrange
      when(databaseHelper.insertWatchlisttv(dummy_data)).thenAnswer((realInvocation) async=> 1,);
      //act
      final result = await dataSource.insertWatchlist(dummy_data);
      //assert
      expect(dummy_data.toJson(), testTvmap);
      expect(result, "Added to Watchlist");

    });
    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(databaseHelper.insertWatchlisttv(dummy_data))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(dummy_data);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });


  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(databaseHelper.removeWatchlistTv(dummy_data))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(dummy_data);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(databaseHelper.removeWatchlistTv(dummy_data))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(dummy_data);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });


  group('Get tv Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(databaseHelper.getMovieById(tId))
          .thenAnswer((_) async => testTvmap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, testTv);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(databaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });
  group('get watchlist movies', () {
    test('should return list of tv from database and from tvseries table', () async {
      // arrange
      when(databaseHelper.getWatchlistMovies())
          .thenAnswer((_) async => [testTvmap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testTv]);
    });
  });

}