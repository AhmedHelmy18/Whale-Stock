import 'package:flutter/material.dart';

class CustomTable<T> extends StatelessWidget {
  final List<String> columns;
  final List<T> items;
  final List<Widget> Function(T item) rowBuilder;

  const CustomTable({
    super.key,
    required this.columns,
    required this.items,
    required this.rowBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingTextStyle: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          columns: columns.map((col) => DataColumn(label: Text(col))).toList(),
          rows: items.map((item) {
            final cells = rowBuilder(item);
            return DataRow(
              cells: cells.map((cell) => DataCell(cell)).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
