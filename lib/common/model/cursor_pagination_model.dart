import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

// generic을 사용하겠다.
@JsonSerializable(
  genericArgumentFactories: true
)
class CursorPaginationModel<T> {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPaginationModel({
    required this.meta,
    required this.data
  });

  // generic을 고려한 build
  factory CursorPaginationModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT)
  => _$CursorPaginationModelFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json)
  => _$CursorPaginationMetaFromJson(json);
}