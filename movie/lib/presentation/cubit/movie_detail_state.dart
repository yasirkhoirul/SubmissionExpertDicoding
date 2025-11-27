part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  final List<Movie> datalistrecomendation;
  final bool isAddedWatchList;
  final MovieDetail? movieDetail;
  final String message;
  final RequestState statusDetail;
  final RequestState statusRecomendation;
  final String watchlismessage;
  const MovieDetailState({
    this.datalistrecomendation = const [],
    this.message = '',
    this.isAddedWatchList = false,
    this.movieDetail,
    this.statusDetail = RequestState.Empty,
    this.statusRecomendation = RequestState.Empty,
    this.watchlismessage = '',
  });

  MovieDetailState copyWith({
    List<Movie>? datalistrecomendation,
    bool? isAddedWatchList,
    MovieDetail? movieDetail,
    String? message,
    RequestState? statusDetail,
    RequestState? statusRecomendation,
    String? watchlismessage,
  }) {
    return MovieDetailState(
      datalistrecomendation:
          datalistrecomendation ?? this.datalistrecomendation,
      isAddedWatchList: isAddedWatchList ?? this.isAddedWatchList,
      message: message ?? this.message,
      movieDetail: movieDetail ?? this.movieDetail,
      statusDetail: statusDetail ?? this.statusDetail,
      statusRecomendation: statusRecomendation ?? this.statusRecomendation,
      watchlismessage: watchlismessage ?? this.watchlismessage,
    );
  }

  @override
  List<Object?> get props => [
    datalistrecomendation,
    isAddedWatchList,
    message,
    movieDetail,
    statusDetail,
    statusRecomendation,
  ];
}
