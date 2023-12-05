import 'package:actual/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)

//어떤 타입을 우리가 넣게 죌지 알 수 없으니까 제네릭으로
//제이슨으로부터 인스턴스화가 어떻게 되는지
class CursorPagination<T> {
  final CursorPaginationMeta meta;
  //리스트를 변환
  final List<T> data;

  CursorPagination({required this.meta, required this.data});
  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}
