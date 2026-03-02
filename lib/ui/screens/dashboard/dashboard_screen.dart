import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:whale_stock/view_models/dashboard_view_model.dart';
import 'package:whale_stock/ui/widgets/stat_card.dart';
import 'package:whale_stock/ui/widgets/chart_container.dart';
import 'package:whale_stock/ui/widgets/legend_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Total Inventory Value',
                    value: '\$${viewModel.totalValue.toStringAsFixed(2)}',
                    icon: Icons.monetization_on_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: StatCard(
                    title: 'Total Items',
                    value: viewModel.totalItems.toString(),
                    icon: Icons.inventory_2_outlined,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: StatCard(
                    title: 'Low Stock Alerts',
                    value: viewModel.lowStockCount.toString(),
                    icon: Icons.warning_amber_outlined,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ChartContainer(
                      title: 'Inventory Growth',
                      chart: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: viewModel.inventoryGrowthData.isEmpty
                                  ? [const FlSpot(0, 0)]
                                  : viewModel.inventoryGrowthData,
                              isCurved: true,
                              color: Theme.of(context).primaryColor,
                              barWidth: 4,
                              isStrokeCapRound: true,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withValues(alpha: .1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ChartContainer(
                      title: 'Category Distribution',
                      chart: viewModel.categoryDistribution.isEmpty
                          ? const Center(child: Text('No data'))
                          : Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace: 2,
                                      centerSpaceRadius: 40,
                                      sections: viewModel
                                          .categoryDistribution.entries
                                          .map((entry) {
                                        final index = viewModel
                                                .categoryDistribution.keys
                                                .toList()
                                                .indexOf(entry.key) %
                                            10;
                                        final colors = [
                                          Colors.blue,
                                          Colors.green,
                                          Colors.orange,
                                          Colors.red,
                                          Colors.purple,
                                          Colors.teal,
                                          Colors.indigo,
                                          Colors.pink,
                                          Colors.amber,
                                          Colors.cyan,
                                        ];
                                        return PieChartSectionData(
                                          value: entry.value.toDouble(),
                                          color: colors[index],
                                          title: '',
                                          radius: 50,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  flex: 1,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: viewModel
                                          .categoryDistribution.entries
                                          .map((entry) {
                                        final index = viewModel
                                                .categoryDistribution.keys
                                                .toList()
                                                .indexOf(entry.key) %
                                            10;
                                        final colors = [
                                          Colors.blue,
                                          Colors.green,
                                          Colors.orange,
                                          Colors.red,
                                          Colors.purple,
                                          Colors.teal,
                                          Colors.indigo,
                                          Colors.pink,
                                          Colors.amber,
                                          Colors.cyan,
                                        ];
                                        return LegendItem(
                                          color: colors[index],
                                          label: entry.key,
                                          value: entry.value.toString(),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
