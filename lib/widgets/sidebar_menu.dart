import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: AppTheme.sidebarBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _buildMenuItem(Icons.grid_view_rounded, 'Dashboard', isSelected: true),
          _buildMenuItem(Icons.inventory_2_outlined, 'Inventory'),
          _buildMenuItem(Icons.receipt_long_outlined, 'Orders'),
          _buildMenuItem(Icons.bar_chart_outlined, 'Reports'),
          _buildMenuItem(Icons.settings_outlined, 'Settings'),
          const Spacer(),
          _buildMenuItem(Icons.help_outline_rounded, 'Support'),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: isSelected
          ? BoxDecoration(
              color: AppTheme.primaryTeal.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: const Border(
                left: BorderSide(color: AppTheme.primaryTeal, width: 4),
              ),
            )
          : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? AppTheme.primaryTeal : AppTheme.textSecondary,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppTheme.primaryTeal : AppTheme.textSecondary,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        hoverColor: Colors.white10,
        onTap: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
