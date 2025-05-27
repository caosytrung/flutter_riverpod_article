import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_article/single_provider_solution/provider/big_product_provider.dart';

class SingleProviderProductPage extends ConsumerWidget {
  const SingleProviderProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productNotifierProvider);

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
                    ref
                        .read(productNotifierProvider.notifier)
                        .updateNameFilter(value);
                  },
                ),
              ),
              const SizedBox(width: 8),
              // Category dropdown
              DropdownButton<String>(
                value:
                    state.categoryFilter.isEmpty ? null : state.categoryFilter,
                hint: const Text("Category"),
                onChanged: (value) {
                  ref
                      .read(productNotifierProvider.notifier)
                      .updateCategoryFilter(value ?? '');
                },
                items: ['All', ...state.categories].map((category) {
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
            itemCount: state.products.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final product = state.products[index];
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
