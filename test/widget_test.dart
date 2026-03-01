import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:whale_stock/main.dart';
import 'package:whale_stock/viewmodels/dashboard_viewmodel.dart';

void main() {
  testWidgets('Dashboard renders correctly', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ],
        child: const MyApp(),
      ),
    );

    // Verify that the dashboard header is present.
    expect(find.text('ULTRA DARK WAREHOUSE DASHBOARD'), findsOneWidget);

    // Reset size
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
