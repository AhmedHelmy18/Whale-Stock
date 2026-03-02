import 'package:flutter/material.dart';
import 'package:whale_stock/core/theme/app_theme.dart';
import 'package:whale_stock/core/utils/toast_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Settings',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        _buildSection(
          context,
          'Preferences',
          [
            _buildSettingRow(
              context,
              'App Theme',
              'System Default',
              Icons.dark_mode_outlined,
              onTap: () {

                ToastManager.showInfo(context, 'Theme settings coming soon');
              },
            ),
            _buildSettingRow(
              context,
              'Currency Symbol',
              'USD (\$)',
              Icons.attach_money,
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 30),
        _buildSection(
          context,
          'Data Management',
          [
            _buildSettingRow(
              context,
              'Backup Data',
              'Manual backup to device',
              Icons.backup_outlined,
              onTap: () {},
            ),
            _buildSettingRow(
              context,
              'Clear All Data',
              'This action cannot be undone',
              Icons.delete_forever_outlined,
              isDestructive: true,
              onTap: () => _showResetDialog(context),
            ),
          ],
        ),
        const Spacer(),
        Center(
          child: Column(
            children: [
              Text(
                'Whale Stock v1.0.0',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryTeal,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.border),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingRow(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon, {
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppTheme.primaryTeal,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text('Reset All Data?'),
        content: const Text(
          'This will delete all products, categories, and history. Are you absolutely sure?',
          style: TextStyle(color: AppTheme.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await Hive.box('products').clear();
              await Hive.box('stock_movements').clear();

              if (context.mounted) {
                Navigator.pop(context);
                ToastManager.showSuccess(
                    context, 'All data cleared successfully');
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete Everything',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
