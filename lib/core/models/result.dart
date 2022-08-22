import 'package:flutter/foundation.dart' show optionalTypeArgs;
import 'package:freezed_annotation/freezed_annotation.dart'
    show DeepCollectionEquality, JsonKey, freezed;

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  const factory Result.data({T? value}) = _Data<T>;
  const factory Result.error({required Exception exception}) = _Error<T>;
}
