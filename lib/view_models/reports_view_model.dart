import 'package:flutter/foundation.dart';
import 'package:whale_stock/repositories/inventory_repository.dart';
import 'package:whale_stock/services/analytics_service.dart';
import 'package:whale_stock/models/product.dart';
import 'package:whale_stock/services/excel_export_service.dart';

class ReportsViewModel extends ChangeNotifier {
  final InventoryRepository _repository;
  final AnalyticsService _analyticsService;
  final ExcelExportService _exportService;

  Map<String, double> _valuationByCategory = {};
  Map<String, double> _supplierDistribution = {};
  List<Product> _lowStockItems = [];
  String _searchQuery = '';
  bool _isExporting = false;

  ReportsViewModel({
    required InventoryRepository repository,
    required AnalyticsService analyticsService,
    required ExcelExportService exportService,
  })  : _repository = repository,
        _analyticsService = analyticsService,
        _exportService = exportService;

  Map<String, double> get valuationByCategory => _valuationByCategory;
  Map<String, double> get supplierDistribution => _supplierDistribution;

  List<Product> get lowStockItems {
    if (_searchQuery.isEmpty) return _lowStockItems;
    final query = _searchQuery.toLowerCase();
    return _lowStockItems
        .where((p) =>
            p.name.toLowerCase().contains(query) ||
            p.categoryId.toLowerCase().contains(query) ||
            (p.supplier?.toLowerCase().contains(query) ?? false) ||
            p.sku.toLowerCase().contains(query))
        .toList();
  }

  bool get isExporting => _isExporting;

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<String?> exportReport() async {
    _isExporting = true;
    notifyListeners();
    try {
      final products = _repository.getProducts();
      return await _exportService.exportProducts(products);
    } finally {
      _isExporting = false;
      notifyListeners();
    }
  }

  void refreshReports() {
    final products = _repository.getProducts();
    _valuationByCategory =
        _analyticsService.calculateValuationByCategory(products);
    _supplierDistribution =
        _analyticsService.calculateSupplierDistribution(products);
    _lowStockItems = _analyticsService.getLowStockProducts(products);
    notifyListeners();
  }
}
