class StockMovementOverTime {
  final String date;
  final double inbound;
  final double outbound;
  final double netChange;

  StockMovementOverTime({
    required this.date,
    required this.inbound,
    required this.outbound,
    required this.netChange,
  });
}

class InventoryByCategory {
  final String category;
  final double quantity;

  InventoryByCategory({
    required this.category,
    required this.quantity,
  });
}

class SupplierDistribution {
  final String supplier;
  final double percentage;

  SupplierDistribution({
    required this.supplier,
    required this.percentage,
  });
}

class MostMovedItem {
  final String itemId;
  final String itemName;
  final String category;
  final int totalMovement;
  final int currentStock;

  MostMovedItem({
    required this.itemId,
    required this.itemName,
    required this.category,
    required this.totalMovement,
    required this.currentStock,
  });
}
