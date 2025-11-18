import 'package:equatable/equatable.dart';


class TvSeriesRecomendationitem extends Equatable{
  final String path;
  final int id;
  TvSeriesRecomendationitem({required this.path,required this.id});
  
  @override
  List<Object?> get props => [
    path,
    id
  ];
  
}