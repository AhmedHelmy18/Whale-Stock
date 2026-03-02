import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:whale_stock/core/theme/app_theme.dart';
import 'package:whale_stock/repositories/inventory_repository.dart';
import 'package:whale_stock/services/excel_export_service.dart';
import 'package:whale_stock/services/analytics_service.dart';
import 'package:whale_stock/view_models/inventory_view_model.dart';
import 'package:whale_stock/view_models/dashboard_view_model.dart';
import 'package:whale_stock/view_models/reports_view_model.dart';
import 'package:whale_stock/ui/layouts/main_layout.dart';
import 'package:whale_stock/ui/screens/dashboard/dashboard_screen.dart';
import 'package:whale_stock/ui/screens/inventory/inventory_screen.dart';
import 'package:whale_stock/ui/screens/reports/reports_screen.dart';
import 'package:whale_stock/ui/screens/settings/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final inventoryRepo = InventoryRepository();
  await inventoryRepo.init();

  final excelService = ExcelExportService();
  final analyticsService = AnalyticsService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => InventoryViewModel(
            repository: inventoryRepo,
            exportService: excelService,
          )..loadProducts(),
        ),
        ChangeNotifierProxyProvider<InventoryViewModel, DashboardViewModel>(
          create: (_) => DashboardViewModel(
            repository: inventoryRepo,
            analyticsService: analyticsService,
          ),
          update: (_, inventory, dashboard) {
            dashboard?.refreshData();
            return dashboard!;
          },
        ),
        ChangeNotifierProxyProvider<InventoryViewModel, ReportsViewModel>(
          create: (_) => ReportsViewModel(
            repository: inventoryRepo,
            analyticsService: analyticsService,
            exportService: excelService,
          ),
          update: (_, inventory, reports) {
            reports?.refreshReports();
            return reports!;
          },
        ),
      ],
      child: const InventoryApp(),
    ),
  );
}

class InventoryApp extends StatelessWidget {
  const InventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whale Stock',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const InventoryScreen(),
    const ReportsScreen(),
    const SettingsScreen(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Inventory',
    'Reports',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: _titles[_selectedIndex],
      selectedIndex: _selectedIndex,
      onItemSelected: (index) => setState(() => _selectedIndex = index),
      onSearch: (query) {
        if (_selectedIndex == 1) {
          context.read<InventoryViewModel>().search(query);
        } else if (_selectedIndex == 2) {
          context.read<ReportsViewModel>().search(query);
        }
      },
      child: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}
