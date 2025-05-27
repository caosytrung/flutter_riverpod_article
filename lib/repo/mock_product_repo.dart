import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_article/model/product.dart';

class MockProductRepo {
  final List<Product> _products = const [
    Product(id: 1, name: 'Product 1', category: 'Electronics'),
    Product(id: 2, name: 'Product 2', category: 'Home & Kitchen'),
    Product(id: 3, name: 'Product 3', category: 'Books'),
  ];

  List<Product> filterProducts({
    String name = '',
    String category = '',
  }) {
    final compareName = name.toLowerCase();

    return _products.where((product) {
      final matchesName =
          name.isEmpty || product.name.toLowerCase().contains(compareName);
      final matchesCategory = category.isEmpty || product.category == category;
      return matchesName && matchesCategory;
    }).toList();
  }

  List<String> fetchAllCategories() {
    return _products.map((product) => product.category).toSet().toList();
  }
}

// Don't mark this one as auto-dispose, as it will be acted as a singleton
final mockProductRepo = StateProvider<MockProductRepo>((ref) {
  return MockProductRepo();
});
