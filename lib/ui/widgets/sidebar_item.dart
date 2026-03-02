import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarItem({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color:
                  isSelected ? primaryColor : theme.textTheme.bodyMedium?.color,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? primaryColor
                    : theme.textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
