part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState{}

final class SearchError extends SearchState{
  final String message;
  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

final class SearchHasData extends SearchState{
  final List<Movie> data;
  const SearchHasData(this.data);

  @override
  List<Object> get props => [data];
}