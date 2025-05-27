import 'package:flutter_riverpod_article/model/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default([]) List<Product> products,
    @Default([]) List<String> categories,
    @Default('') String nameFilter,
    @Default('') String categoryFilter,
  }) = _ProductState;
}