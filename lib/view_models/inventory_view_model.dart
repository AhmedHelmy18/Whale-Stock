import 'package:flutter/foundation.dart' hide Category;
import 'package:whale_stock/models/product.dart';
import 'package:whale_stock/models/category.dart';
import 'package:whale_stock/repositories/inventory_repository.dart';
import 'package:whale_stock/services/excel_export_service.dart';

class InventoryViewModel extends ChangeNotifier {
  final InventoryRepository _repository;
  final ExcelExportService _exportService;

  List<Product> _products = [];
  List<Category> _categories = [];
  String _searchQuery = '';
  bool _isLoading = false;

  InventoryViewModel({
    required InventoryRepository repository,
    required ExcelExportService exportService,
  })  : _repository = repository,
        _exportService = exportService;

  List<Product> get products {
    if (_searchQuery.isEmpty) return _products;
    return _products
        .where((p) =>
            p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.sku.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.id.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    _products = _repository.getProducts();
    _categories = _repository.getCategories();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    await _repository.addProduct(product);
    await loadProducts();
  }

  Future<void> updateProduct(Product product) async {
    await _repository.updateProduct(product);
    await loadProducts();
  }

  Future<void> deleteProduct(String id) async {
    await _repository.deleteProduct(id);
    await loadProducts();
  }

  Future<String?> exportToExcel() async {
    return await _exportService.exportProducts(_products);
  }
}
