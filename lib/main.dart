import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whale_stock/theme/app_theme.dart';
import 'package:whale_stock/viewmodels/dashboard_viewmodel.dart';
import 'package:whale_stock/views/dashboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warehouse Dashboard',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
    );
  }
}
