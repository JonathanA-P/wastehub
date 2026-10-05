import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/monitoring/screens/logistics_tracking_screen.dart';

void main() {
  testWidgets('LogisticsTrackingScreen renders GPS map, driver info, and weighbridge',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LogisticsTrackingScreen(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));

    // Verify Title & Contract Code
    expect(find.text('Monitoring & Tracking Logistik'), findsOneWidget);
    expect(find.text('#WH-CTR-2026-0941'), findsOneWidget);

    // Verify Vehicle & Driver
    expect(find.text('B 9241 UZ'), findsOneWidget);
    expect(find.textContaining('Ahmad Supriadi'), findsOneWidget);

    // Verify Tabs
    expect(find.text('Rute & GPS'), findsOneWidget);
    expect(find.text('Jembatan Timbang'), findsOneWidget);
    expect(find.text('Dokumen e-DO'), findsOneWidget);

    // Switch to Jembatan Timbang tab
    await tester.tap(find.text('Jembatan Timbang'));
    await tester.pump(const Duration(milliseconds: 300));

    // Verify digital weighbridge metrics
    expect(find.text('Tiket Timbang Elektronik'), findsOneWidget);
    expect(find.text('13480 kg'), findsOneWidget); // Bruto
    expect(find.text('5480 kg'), findsOneWidget); // Tarra
    expect(find.text('8000 kg'), findsOneWidget); // Netto
    expect(find.text('WB-20261005-0982'), findsOneWidget);
  });
}
