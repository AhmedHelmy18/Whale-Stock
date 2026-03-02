import 'package:flutter/material.dart';
import 'package:whale_stock/core/utils/toast_manager.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:whale_stock/view_models/reports_view_model.dart';
import 'package:whale_stock/ui/widgets/custom_table.dart';
import 'package:whale_stock/models/product.dart';
import 'package:whale_stock/ui/widgets/chart_container.dart';
import 'package:whale_stock/ui/widgets/legend_item.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportsViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Stock Reports',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: viewModel.isExporting
                        ? null
                        : () async {
                            final path = await viewModel.exportReport();
                            if (context.mounted) {
                              if (path != null) {
                                ToastManager.showSuccess(
                                    context, 'Report exported to: $path');
                              } else {
                                ToastManager.showError(
                                    context, 'Failed to export report');
                              }
                            }
                          },
                    icon: viewModel.isExporting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.download),
                    label: Text(viewModel.isExporting
                        ? 'Exporting...'
                        : 'Export Full Report'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Valuation per Category
              ChartContainer(
                title: 'Inventory Valuation by Category (\$)',
                height: 300,
                chart: viewModel.valuationByCategory.isEmpty
                    ? const Center(child: Text('No data'))
                    : BarChart(
                        BarChartData(
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              getTooltipColor: (_) => Colors.blueGrey[800]!,
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                return BarTooltipItem(
                                  '\$${rod.toY.toStringAsFixed(2)}',
                                  const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                          gridData: const FlGridData(show: false),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final index = value.toInt();
                                  if (index < 0 ||
                                      index >=
                                          viewModel
                                              .valuationByCategory.length) {
                                    return const SizedBox();
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      viewModel.valuationByCategory.keys
                                          .elementAt(index),
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  );
                                },
                              ),
                            ),
                            leftTitles: const AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true, reservedSize: 40)),
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: viewModel.valuationByCategory.entries
                              .map((entry) {
                            final index = viewModel.valuationByCategory.keys
                                .toList()
                                .indexOf(entry.key);
                            final colors = [
                              Colors.blue,
                              Colors.green,
                              Colors.orange,
                              Colors.red,
                              Colors.purple,
                              Colors.teal
                            ];
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: entry.value,
                                  color: colors[index % colors.length],
                                  width: 40,
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(4)),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
              ),
              const SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Supplier Distribution
                  Expanded(
                    child: ChartContainer(
                      title: 'Supplier Distribution (%)',
                      height: 300,
                      chart: viewModel.supplierDistribution.isEmpty
                          ? const Center(child: Text('No data'))
                          : Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace: 2,
                                      centerSpaceRadius: 40,
                                      sections: viewModel
                                          .supplierDistribution.entries
                                          .map((entry) {
                                        final index = viewModel
                                                .supplierDistribution.keys
                                                .toList()
                                                .indexOf(entry.key) %
                                            6;
                                        final colors = [
                                          Colors.blue,
                                          Colors.green,
                                          Colors.orange,
                                          Colors.red,
                                          Colors.purple,
                                          Colors.teal
                                        ];
                                        return PieChartSectionData(
                                          value: entry.value,
                                          color: colors[index],
                                          title: '', // Hide in-chart label
                                          radius: 50,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: viewModel
                                          .supplierDistribution.entries
                                          .map((entry) {
                                        final index = viewModel
                                                .supplierDistribution.keys
                                                .toList()
                                                .indexOf(entry.key) %
                                            6;
                                        final colors = [
                                          Colors.blue,
                                          Colors.green,
                                          Colors.orange,
                                          Colors.red,
                                          Colors.purple,
                                          Colors.teal
                                        ];
                                        return LegendItem(
                                          color: colors[index],
                                          label: entry.key,
                                          value:
                                              '${entry.value.toStringAsFixed(1)}%',
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Summary Stats or placeholder
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: 300,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5))
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Valuation Summary',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          _buildSummaryRow(context, 'Total Stock Value',
                              '\$${viewModel.valuationByCategory.values.fold(0.0, (a, b) => a + b).toStringAsFixed(2)}'),
                          const Divider(height: 30),
                          _buildSummaryRow(
                              context,
                              'Top Category',
                              viewModel.valuationByCategory.isEmpty
                                  ? 'N/A'
                                  : viewModel.valuationByCategory.entries
                                      .reduce(
                                          (a, b) => a.value > b.value ? a : b)
                                      .key),
                          const Divider(height: 30),
                          _buildSummaryRow(context, 'Critical Low Stock',
                              viewModel.lowStockItems.length.toString()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Low Stock Alert Details
              const Text(
                'Low Stock Detail Analysis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 400,
                child: CustomTable<Product>(
                  columns: const [
                    'ID',
                    'Name',
                    'Category',
                    'Stock',
                    'Supplier'
                  ],
                  items: viewModel.lowStockItems,
                  rowBuilder: (product) => [
                    Text(product.id),
                    Text(product.name),
                    Text(product.categoryId),
                    Text(product.quantity.toString(),
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                    Text(product.supplier ?? 'Not Assigned'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
