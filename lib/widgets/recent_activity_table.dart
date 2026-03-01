import 'package:flutter/material.dart';
import '../models/inventory_models.dart';
import '../theme/app_theme.dart';

class RecentActivityTable extends StatelessWidget {
  final List<RecentActivity> activities;

  const RecentActivityTable({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'RECENT ACTIVITY',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Recent Activity',
                        style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.keyboard_arrow_down, color: AppTheme.textSecondary, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DataTable(
            headingRowColor: WidgetStateProperty.all(AppTheme.background.withValues(alpha: 0.5)),
            headingTextStyle: const TextStyle(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            dataTextStyle: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
            ),
            dividerThickness: 1,
            columnSpacing: 24,
            horizontalMargin: 24,
            columns: const [
              DataColumn(label: Text('Item')),
              DataColumn(label: Text('Stock In/Out')),
              DataColumn(label: Text('Quantity')),
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Date/Time')),
              DataColumn(label: Text('Action')),
            ],
            rows: activities.map((activity) => DataRow(
              cells: [
                DataCell(Text(activity.item, style: const TextStyle(color: AppTheme.textPrimary))),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryTeal.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.primaryTeal.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      activity.type,
                      style: const TextStyle(color: AppTheme.primaryTeal, fontSize: 11),
                    ),
                  ),
                ),
                DataCell(Text(activity.quantity.toString())),
                DataCell(Text(activity.location)),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryTeal.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.primaryTeal.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      activity.status,
                      style: const TextStyle(color: AppTheme.primaryTeal, fontSize: 11),
                    ),
                  ),
                ),
                DataCell(Text(activity.dateTime)),
                DataCell(
                  Text(
                    activity.actionUrl,
                    style: const TextStyle(
                      color: AppTheme.primaryTeal,
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )).toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
