
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

@freezed
abstract class Product  with _$Product {

  const factory Product({
    required int id,
    required String name,
    required String category,
  }) = _Product;
}
