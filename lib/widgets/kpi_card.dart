import 'package:flutter/material.dart';
import 'package:whale_stock/models/inventory_models.dart';
import 'package:whale_stock/core/theme/app_theme.dart';

class KpiCard extends StatelessWidget {
  final KpiData kpi;
  final bool isAlert;

  const KpiCard({super.key, required this.kpi, this.isAlert = false});

  IconData _getIconData(String? iconName) {
    switch (iconName) {
      case 'layers':
        return Icons.layers_outlined;
      case 'warning':
        return Icons.warning_amber_rounded;
      case 'attach_money':
        return Icons.attach_money_rounded;
      case 'assignment':
        return Icons.assignment_outlined;
      case 'local_shipping':
        return Icons.local_shipping_outlined;
      case 'reply':
        return Icons.reply_outlined;
      case 'loop':
        return Icons.loop_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (isAlert ? AppTheme.alertRed : AppTheme.primaryTeal)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getIconData(kpi.icon),
                color: isAlert ? AppTheme.alertRed : AppTheme.primaryTeal,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    kpi.title,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    kpi.value,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
