import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whale_stock/view_models/inventory_view_model.dart';
import 'package:whale_stock/ui/widgets/custom_table.dart';
import 'package:whale_stock/models/product.dart';
import 'package:whale_stock/widgets/add_edit_product_modal.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            Row(
              children: [
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () => viewModel.exportToExcel(),
                  icon: const Icon(Icons.download),
                  label: const Text('Export Excel'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton.icon(
                  onPressed: () async {
                    final Product? newProduct = await showDialog<Product>(
                      context: context,
                      builder: (context) => const AddEditProductModal(),
                    );
                    if (newProduct != null) {
                      await viewModel.addProduct(newProduct);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Product'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: CustomTable<Product>(
                columns: const [
                  'ID',
                  'Name',
                  'SKU',
                  'Price',
                  'Quantity',
                  'Supplier',
                  'Actions'
                ],
                items: viewModel.products,
                rowBuilder: (product) => [
                  Text(product.id),
                  Text(product.name),
                  Text(product.sku),
                  Text('\$${product.price.toStringAsFixed(2)}'),
                  Text(product.quantity.toString()),
                  Text(product.supplier ?? '-'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () async {
                          final Product? updatedProduct =
                              await showDialog<Product>(
                            context: context,
                            builder: (context) => AddEditProductModal(
                              product: product,
                            ),
                          );
                          if (updatedProduct != null) {
                            await viewModel.updateProduct(updatedProduct);
                          }
                        },
                      ),
                      IconButton(
                        icon:
                            const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => viewModel.deleteProduct(product.id),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
