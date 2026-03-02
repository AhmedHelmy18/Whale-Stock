import 'package:hive/hive.dart';

part 'stock_movement.g.dart';

@HiveType(typeId: 2)
class StockMovement extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productId;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final DateTime timestamp;

  StockMovement({
    required this.id,
    required this.productId,
    required this.type,
    required this.quantity,
    required this.timestamp,
  });
}
