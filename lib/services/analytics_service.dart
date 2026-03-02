import 'package:whale_stock/models/product.dart';

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

  Map<String, int> calculateCategoryDistribution(List<Product> products) {
    final Map<String, int> distribution = {};
    for (var product in products) {
      distribution[product.categoryId] =
          (distribution[product.categoryId] ?? 0) + 1;
    }
    return distribution;
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
