import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_article/model/product.dart';
import 'package:flutter_riverpod_article/repo/mock_product_repo.dart';

final nameFilterProvider = StateProvider.autoDispose<String>((ref) => '');

final categoryFilterProvider = StateProvider.autoDispose<String>((ref) => '');

final allCategoriesProvider = Provider.autoDispose<List<String>>((ref) {
  final repository = ref.watch(mockProductRepo);
  return repository.fetchAllCategories();
}, dependencies: [mockProductRepo]);

final productProvider = Provider.autoDispose<List<Product>>((ref) {
  final nameFilter = ref.watch(nameFilterProvider);
  final categoryFilter = ref.watch(categoryFilterProvider);
  final repository = ref.watch(mockProductRepo);

  return repository.filterProducts(
    name: nameFilter,
    category: categoryFilter,
  );
}, dependencies: [
  nameFilterProvider,
  categoryFilterProvider,
  mockProductRepo,
]);
