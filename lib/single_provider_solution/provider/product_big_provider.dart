import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_article/repo/mock_product_repo.dart';
import 'package:flutter_riverpod_article/single_provider_solution/state/state.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final MockProductRepo repository;

  ProductNotifier(this.repository)
      : super(ProductState(
          products: repository.filterProducts(),
          categories: repository.fetchAllCategories(),
        ));

  void updateNameFilter(String name) {
    state = state.copyWith(
        nameFilter: name,
        products: repository.filterProducts(
            name: name, category: state.categoryFilter));
  }

  void updateCategoryFilter(String category) {
    state = state.copyWith(
      categoryFilter: category,
      products:
          repository.filterProducts(name: state.nameFilter, category: category),
    );
  }
}

final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, ProductState>(
  (ref) => ProductNotifier(ref.read(mockProductRepo)),
);
