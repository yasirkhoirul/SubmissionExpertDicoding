import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_response.g.dart';
@JsonSerializable()
class TvResponse extends Equatable{
  final double page;
  final List<TvModel>? results;
  TvResponse(this.page, this.results);

  factory TvResponse.fromJson(Map<String,dynamic> json)=> _$TvResponseFromJson(json);

  
  @override
  List<Object?> get props => [
    page,
    results
  ];
}