import 'package:whale_stock/models/product.dart';
import 'package:whale_stock/models/category.dart';

class AnalyticsService {
  double calculateTotalValue(List<Product> products) {
    return products.fold(0, (sum, p) => sum + (p.price * p.quantity));
  }

  int calculateTotalItems(List<Product> products) {
    return products.fold(0, (sum, p) => sum + p.quantity);
  }

  List<Product> getLowStockProducts(List<Product> products, [int? threshold]) {
    return products
        .where((p) => p.quantity <= (threshold ?? p.reorderLevel))
        .toList();
  }

  Map<String, int> calculateCategoryDistribution(
      List<Product> products, List<Category> categories) {
    final Map<String, int> distribution = {};
    final Map<String, String> categoryMap = {
      for (var c in categories) c.id: c.name
    };

    for (var product in products) {
      final categoryName =
          categoryMap[product.categoryId] ?? product.categoryId;
      distribution[categoryName] = (distribution[categoryName] ?? 0) + 1;
    }
    return distribution;
  }

  List<double> calculateInventoryGrowth(List<Product> products) {
    // Since we don't have historical data, we'll create a trend based on total items
    final total = calculateTotalItems(products).toDouble();
    if (total == 0) return [0, 0, 0, 0, 0];

    // Mocked trend: last 5 data points leading up to the current total
    return [
      total * 0.7,
      total * 0.85,
      total * 0.8,
      total * 0.95,
      total,
    ];
  }

  Map<String, double> calculateValuationByCategory(List<Product> products) {
    final Map<String, double> valuation = {};
    for (var product in products) {
      final value = product.price * product.quantity;
      valuation[product.categoryId] =
          (valuation[product.categoryId] ?? 0) + value;
    }
    return valuation;
  }

  Map<String, double> calculateSupplierDistribution(List<Product> products) {
    final Map<String, double> distribution = {};
    final totalVal = calculateTotalValue(products);
    if (totalVal == 0) return {};

    for (var product in products) {
      final supplier = product.supplier ?? 'Unknown';
      final value = product.price * product.quantity;
      distribution[supplier] =
          (distribution[supplier] ?? 0) + (value / totalVal * 100);
    }
    return distribution;
  }
}
