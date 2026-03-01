import 'package:flutter/material.dart';
import '../models/report_models.dart';

class ReportsViewModel extends ChangeNotifier {
  List<StockMovementOverTime> _stockMovements = [];
  List<InventoryByCategory> _inventoryByCategory = [];
  List<SupplierDistribution> _supplierDistribution = [];
  List<MostMovedItem> _mostMovedItems = [];

  List<StockMovementOverTime> get stockMovements => _stockMovements;
  List<InventoryByCategory> get inventoryByCategory => _inventoryByCategory;
  List<SupplierDistribution> get supplierDistribution => _supplierDistribution;
  List<MostMovedItem> get mostMovedItems => _mostMovedItems;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  ReportsViewModel() {
    _loadMockData();
  }

  Future<void> _loadMockData() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _stockMovements = [
      StockMovementOverTime(date: 'Oct 1', inbound: 0, outbound: 0, netChange: 0),
      StockMovementOverTime(date: 'Oct 5', inbound: 500, outbound: 300, netChange: 200),
      StockMovementOverTime(date: 'Oct 10', inbound: 1000, outbound: 800, netChange: 200),
      StockMovementOverTime(date: 'Oct 15', inbound: 1200, outbound: 550, netChange: 650),
      StockMovementOverTime(date: 'Oct 21', inbound: 800, outbound: 900, netChange: -100),
      StockMovementOverTime(date: 'Oct 31', inbound: 1500, outbound: 1200, netChange: 300),
    ];

    _inventoryByCategory = [
      InventoryByCategory(category: 'Raw Materials', quantity: 4500),
      InventoryByCategory(category: 'Work in Progress', quantity: 1200),
      InventoryByCategory(category: 'Finished Goods', quantity: 3200),
      InventoryByCategory(category: 'Packaging', quantity: 3000),
      InventoryByCategory(category: 'MRO Supplies', quantity: 2800),
    ];

    _supplierDistribution = [
      SupplierDistribution(supplier: 'Supplier A', percentage: 35),
      SupplierDistribution(supplier: 'Supplier B', percentage: 25),
      SupplierDistribution(supplier: 'Supplier C', percentage: 20),
      SupplierDistribution(supplier: 'Other', percentage: 20),
    ];

    _mostMovedItems = [
      MostMovedItem(
        itemId: 'RM-001',
        itemName: 'Steel Sheets',
        category: 'Raw Materials',
        totalMovement: 4500,
        currentStock: 800,
      ),
      MostMovedItem(
        itemId: 'FG-102',
        itemName: 'Widget Assembly',
        category: 'Finished Goods',
        totalMovement: 3200,
        currentStock: 1200,
      ),
      MostMovedItem(
        itemId: 'PK-505',
        itemName: 'Cardboard Boxes',
        category: 'Packaging',
        totalMovement: 2800,
        currentStock: 5000,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }
}
