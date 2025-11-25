part of 'search_tv_bloc.dart';

sealed class SearchTvEvent extends Equatable {
  const SearchTvEvent();
  
  @override
  List<Object> get props => [];
}

class OnSearchTvQuery extends SearchTvEvent{
  final String query;
  const OnSearchTvQuery(this.query);

  @override
  List<Object> get props => [query];
}
