import 'package:built_collection/built_collection.dart';
import 'package:json_annotation/json_annotation.dart';

class BuiltListConverter<T> implements JsonConverter<BuiltList<T>, List<T>> {
  const BuiltListConverter();

  @override
  BuiltList<T> fromJson(List<T> json) => BuiltList.of(json);

  @override
  List<T> toJson(BuiltList<T> object) => object.toList();
}
