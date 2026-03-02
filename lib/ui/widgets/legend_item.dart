import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String? value;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (value != null) ...[
            const SizedBox(width: 4),
            Flexible(
              flex: 2,
              child: Text(
                value!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
