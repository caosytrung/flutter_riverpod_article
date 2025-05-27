import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_article/multiple_provider_solution/provider/multiple_product_providers.dart';

class MultipleProviderProductPage extends ConsumerWidget {
  const MultipleProviderProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);
    final allCategories = ref.watch(allCategoriesProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search by name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    ref.read(nameFilterProvider.notifier).state = value;
                  },
                ),
              ),
              const SizedBox(width: 8),
              // Category dropdown
              DropdownButton<String>(
                value: '',
                hint: const Text("Category"),
                onChanged: (value) {
                  ref.read(categoryFilterProvider.notifier).state = value ?? '';
                },
                items: ['All', ...allCategories].map((category) {
                  return DropdownMenuItem(
                    value: category == 'All' ? '' : category,
                    child: Text(category),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        // 🧾 Product List
        Expanded(
          child: ListView.separated(
            itemCount: products.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: CircleAvatar(child: Text(product.id.toString())),
                title: Text(product.name),
                subtitle: Text(product.category),
              );
            },
          ),
        ),
      ],
    );
  }
}
