import 'package:flutter/widgets.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:whale_stock/repositories/inventory_repository.dart';
import 'package:whale_stock/services/analytics_service.dart';

class DashboardViewModel extends ChangeNotifier {
  final InventoryRepository _repository;
  final AnalyticsService _analyticsService;

  double _totalValue = 0;
  int _totalItems = 0;
  int _lowStockCount = 0;
  Map<String, int> _categoryDistribution = {};
  List<FlSpot> _inventoryGrowthData = [];

  DashboardViewModel({
    required InventoryRepository repository,
    required AnalyticsService analyticsService,
  })  : _repository = repository,
        _analyticsService = analyticsService;

  double get totalValue => _totalValue;
  int get totalItems => _totalItems;
  int get lowStockCount => _lowStockCount;
  Map<String, int> get categoryDistribution => _categoryDistribution;
  List<FlSpot> get inventoryGrowthData => _inventoryGrowthData;

  void refreshData() {
    final products = _repository.getProducts();
    final categories = _repository.getCategories();

    _totalValue = _analyticsService.calculateTotalValue(products);
    _totalItems = _analyticsService.calculateTotalItems(products);
    _lowStockCount = _analyticsService.getLowStockProducts(products, 5).length;

    _categoryDistribution =
        _analyticsService.calculateCategoryDistribution(products, categories);

    final growthPoints = _analyticsService.calculateInventoryGrowth(products);
    _inventoryGrowthData = growthPoints.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), e.value);
    }).toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
