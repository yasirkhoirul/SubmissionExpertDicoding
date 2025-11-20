// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvResponse _$TvResponseFromJson(Map<String, dynamic> json) => TvResponse(
      (json['page'] as num).toDouble(),
      (json['results'] as List<dynamic>?)
          ?.map((e) => TvModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

