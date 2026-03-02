import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String sku;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final int quantity;

  @HiveField(5)
  final String categoryId;

  @HiveField(6)
  final String? supplier;

  @HiveField(7, defaultValue: 10)
  final int reorderLevel;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    required this.quantity,
    required this.categoryId,
    this.supplier,
    this.reorderLevel = 10,
  });

  Product copyWith({
    String? id,
    String? name,
    String? sku,
    double? price,
    int? quantity,
    String? categoryId,
    String? supplier,
    int? reorderLevel,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      categoryId: categoryId ?? this.categoryId,
      supplier: supplier ?? this.supplier,
      reorderLevel: reorderLevel ?? this.reorderLevel,
    );
  }
}
