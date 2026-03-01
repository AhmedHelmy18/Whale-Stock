class KpiData {
  final String title;
  final String value;
  final String? icon;

  KpiData({required this.title, required this.value, this.icon});
}

class StockLevel {
  final String time;
  final double level;

  StockLevel({required this.time, required this.level});
}

class StockMovement {
  final String time;
  final double outMovement;
  final double inMovement;

  StockMovement({required this.time, required this.outMovement, required this.inMovement});
}

class RecentActivity {
  final String item;
  final String type;
  final int quantity;
  final String location;
  final String status;
  final String dateTime;
  final String actionUrl;

  RecentActivity({
    required this.item,
    required this.type,
    required this.quantity,
    required this.location,
    required this.status,
    required this.dateTime,
    required this.actionUrl,
  });
}
