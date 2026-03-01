import 'package:flutter/foundation.dart';
import 'package:whale_stock/models/inventory_models.dart';

class DashboardViewModel extends ChangeNotifier {
  List<KpiData> get topKpis => [
        KpiData(title: 'TOTAL PRODUCTS', value: '15,420', icon: 'layers'),
        KpiData(title: 'LOW STOCK ALERTS', value: '245', icon: 'warning'),
        KpiData(title: 'STOCK VALUE', value: '\$1,250,000', icon: 'attach_money'),
        KpiData(title: 'ACTIVE ORDERS', value: '58', icon: 'assignment'),
      ];

  List<KpiData> get bottomKpis => [
        KpiData(title: 'PENDING SHIPMENTS', value: '120', icon: 'local_shipping'),
        KpiData(title: 'RETURNING SHIPMENTS', value: '15', icon: 'reply'),
        KpiData(title: 'RETURNS PROCESSING', value: '15', icon: 'loop'),
      ];

  List<StockLevel> get stockLevels => [
        StockLevel(time: '00:00', level: 20),
        StockLevel(time: '03:00', level: 48),
        StockLevel(time: '06:00', level: 25),
        StockLevel(time: '09:00', level: 70),
        StockLevel(time: '12:00', level: 52),
        StockLevel(time: '15:00', level: 60),
        StockLevel(time: '18:00', level: 90),
        StockLevel(time: '21:00', level: 45),
        StockLevel(time: '24:00', level: 75),
      ];

  List<StockMovement> get stockMovements => [
        StockMovement(time: '00:00', inMovement: 70, outMovement: 120),
        StockMovement(time: '03:00', inMovement: 145, outMovement: 95),
        StockMovement(time: '06:00', inMovement: 75, outMovement: 105),
        StockMovement(time: '09:00', inMovement: 140, outMovement: 170),
        StockMovement(time: '12:00', inMovement: 180, outMovement: 95),
        StockMovement(time: '15:00', inMovement: 150, outMovement: 70),
      ];

  List<RecentActivity> get recentActivities => [
        RecentActivity(
          item: 'Product A',
          type: 'Stock In/Out',
          quantity: 200,
          location: 'Location A',
          status: 'Completed',
          dateTime: '10/05/2023, 12:37:00',
          actionUrl: 'Learn more',
        ),
        RecentActivity(
          item: 'Product B',
          type: 'Stock',
          quantity: 200,
          location: 'Location B',
          status: 'Completed',
          dateTime: '12/05/2023, 12:37:00',
          actionUrl: 'Learn more',
        ),
        RecentActivity(
          item: 'Product C',
          type: 'Stock In/Out',
          quantity: 25,
          location: 'Location C',
          status: 'Completed',
          dateTime: '10/05/2023, 12:37:00',
          actionUrl: 'Learn more',
        ),
        RecentActivity(
          item: 'Product D',
          type: 'Stock In/Out',
          quantity: 20,
          location: 'Location D',
          status: 'Completed',
          dateTime: '10/05/2023, 12:37:00',
          actionUrl: 'Learn more',
        ),
      ];
}
