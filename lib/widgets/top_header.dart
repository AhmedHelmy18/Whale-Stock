import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      decoration: const BoxDecoration(
        color: AppTheme.background,
        border: Border(bottom: BorderSide(color: AppTheme.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'ULTRA DARK WAREHOUSE DASHBOARD',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.account_circle_outlined, color: AppTheme.textSecondary),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none_outlined, color: AppTheme.textSecondary),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.alertRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.sidebarBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.border),
                ),
                child: const TextField(
                  style: TextStyle(color: AppTheme.textPrimary, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: AppTheme.textSecondary),
                    prefixIcon: Icon(Icons.search, color: AppTheme.textSecondary, size: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
