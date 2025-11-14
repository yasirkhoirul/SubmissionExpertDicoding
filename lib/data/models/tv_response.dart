import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_response.g.dart';
@JsonSerializable()
class TvResponse extends Equatable{
  final double page;
  final List<TvModel>? result;
  TvResponse(this.page, this.result);

  factory TvResponse.fromJson(Map<String,dynamic> json)=> _$TvResponseFromJson(json);
  Map<String,dynamic> toJson() => _$TvResponseToJson(this);
  
  @override
  List<Object?> get props => [
    page,
    result
  ];
}