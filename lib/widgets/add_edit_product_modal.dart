import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whale_stock/core/theme/app_theme.dart';
import 'package:whale_stock/models/product.dart';
import 'package:whale_stock/view_models/inventory_view_model.dart';

class AddEditProductModal extends StatefulWidget {
  final Product? product;
  final VoidCallback? onSave;

  const AddEditProductModal({
    super.key,
    this.product,
    this.onSave,
  });

  @override
  State<AddEditProductModal> createState() => _AddEditProductModalState();
}

class _AddEditProductModalState extends State<AddEditProductModal> {
  String? _selectedCategory;
  late TextEditingController _nameController;
  late TextEditingController _skuController;
  late TextEditingController _priceController;
  late TextEditingController _initialStockController;
  late TextEditingController _reorderLevelController;
  late TextEditingController _supplierController;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameController = TextEditingController(text: p?.name ?? '');
    _skuController = TextEditingController(
      text: p?.sku ??
          'SKU-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
    );
    _priceController =
        TextEditingController(text: p?.price.toStringAsFixed(2) ?? '0.00');
    _initialStockController =
        TextEditingController(text: p?.quantity.toString() ?? '0');
    _reorderLevelController =
        TextEditingController(text: p?.reorderLevel.toString() ?? '10');
    _supplierController = TextEditingController(text: p?.supplier ?? '');
    _selectedCategory = p?.categoryId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _priceController.dispose();
    _initialStockController.dispose();
    _reorderLevelController.dispose();
    _supplierController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product == null ? 'Add Product' : 'Edit Product',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: AppTheme.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextField('Product Name', controller: _nameController),
            const SizedBox(height: 16),
            _buildTextField(
              'SKU',
              controller: _skuController,
              suffixText: 'Auto-generated',
            ),
            const SizedBox(height: 16),
            _buildDropdownField('Category', [
              'Electronics',
              'Raw Materials',
              'Finished Goods',
              'Packaging'
            ]),
            const SizedBox(height: 16),
            _buildTextField('Supplier', controller: _supplierController),
            const SizedBox(height: 16),
            _buildTextField('Price', controller: _priceController),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildNumberField(
                    'Initial Stock',
                    _initialStockController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildNumberField(
                    'Reorder Level',
                    _reorderLevelController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel',
                      style: TextStyle(color: AppTheme.primaryTeal)),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    final product = Product(
                      id: widget.product?.id ??
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      name: _nameController.text,
                      sku: _skuController.text,
                      price: double.tryParse(_priceController.text) ?? 0.0,
                      quantity: int.tryParse(_initialStockController.text) ?? 0,
                      categoryId: _selectedCategory ?? 'electronics',
                      supplier: _supplierController.text,
                      reorderLevel:
                          int.tryParse(_reorderLevelController.text) ?? 10,
                    );
                    Navigator.of(context).pop(product);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryTeal,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label,
      {TextEditingController? controller,
      String? initialValue,
      String? suffixText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryTeal),
            ),
            suffixText: suffixText,
            suffixStyle:
                const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return Consumer<InventoryViewModel>(
      builder: (context, viewModel, child) {
        final categories = viewModel.categories;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory ??
                  (categories.isNotEmpty ? categories.first.id : null),
              dropdownColor: AppTheme.background,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppTheme.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppTheme.primaryTeal),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppTheme.primaryTeal),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppTheme.primaryTeal),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              icon: const Icon(Icons.arrow_drop_down,
                  color: AppTheme.primaryTeal),
              items: categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat.id,
                  child: Text(cat.name),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildNumberField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryTeal),
            ),
            suffixIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    final int val = int.tryParse(controller.text) ?? 0;
                    controller.text = (val + 1).toString();
                  },
                  child: const Icon(Icons.keyboard_arrow_up,
                      color: AppTheme.textSecondary, size: 16),
                ),
                GestureDetector(
                  onTap: () {
                    final int val = int.tryParse(controller.text) ?? 0;
                    if (val > 0) {
                      controller.text = (val - 1).toString();
                    }
                  },
                  child: const Icon(Icons.keyboard_arrow_down,
                      color: AppTheme.textSecondary, size: 16),
                ),
              ],
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
