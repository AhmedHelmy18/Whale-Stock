import 'package:hive_flutter/hive_flutter.dart';
import 'package:whale_stock/models/product.dart';
import 'package:whale_stock/models/category.dart';
import 'package:whale_stock/models/stock_movement.dart';

class InventoryRepository {
  static const String productBoxName = 'products';
  static const String categoryBoxName = 'categories';
  static const String movementBoxName = 'stock_movements';

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(CategoryAdapter());
    if (!Hive.isAdapterRegistered(1)) Hive.registerAdapter(ProductAdapter());
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(StockMovementAdapter());
    }

    await Hive.openBox<Product>(productBoxName);
    await Hive.openBox<Category>(categoryBoxName);
    await Hive.openBox<StockMovement>(movementBoxName);

    // Initialize default categories if empty
    if (_categoryBox.isEmpty) {
      final defaults = [
        Category(id: 'electronics', name: 'Electronics'),
        Category(id: 'raw-materials', name: 'Raw Materials'),
        Category(id: 'finished-goods', name: 'Finished Goods'),
        Category(id: 'packaging', name: 'Packaging'),
      ];
      for (var cat in defaults) {
        await _categoryBox.put(cat.id, cat);
      }
    }
  }

  Box<Product> get _productBox => Hive.box<Product>(productBoxName);
  Box<Category> get _categoryBox => Hive.box<Category>(categoryBoxName);
  Box<StockMovement> get _movementBox =>
      Hive.box<StockMovement>(movementBoxName);

  // Product Operations
  List<Product> getProducts() => _productBox.values.toList();

  Future<void> addProduct(Product product) async {
    await _productBox.put(product.id, product);
  }

  Future<void> updateProduct(Product product) async {
    await _productBox.put(product.id, product);
  }

  Future<void> deleteProduct(String id) async {
    await _productBox.delete(id);
  }

  // Category Operations
  List<Category> getCategories() => _categoryBox.values.toList();

  Future<void> addCategory(Category category) async {
    await _categoryBox.put(category.id, category);
  }

  // Stock Movement Operations
  List<StockMovement> getMovements() => _movementBox.values.toList();

  Future<void> addMovement(StockMovement movement) async {
    await _movementBox.put(movement.id, movement);
  }
}
