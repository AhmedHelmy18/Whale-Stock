import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final String title;
  final Widget chart;
  final double? height;

  const ChartContainer({
    super.key,
    required this.title,
    required this.chart,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            Expanded(child: chart),
          ],
        ),
      ),
    );

    if (height != null) {
      return SizedBox(height: height, child: content);
    }
    return content;
  }
}
