import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/business/screens/business_dashboard_screen.dart';

void main() {
  testWidgets('BusinessDashboardScreen renders company profile, escrow, and facilities',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: BusinessDashboardScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify company name & NIB
    expect(find.text('PT WasteHub Industri Indonesia'), findsOneWidget);
    expect(find.textContaining('0220008819281'), findsOneWidget);

    // Verify Escrow balance
    expect(find.text('Rp 184.250.000'), findsOneWidget);
    expect(find.text('Top Up Escrow'), findsOneWidget);

    // Verify ESG & Warehouse
    expect(find.text('Gudang Hub Karawang (Kapasitas 120 Ton)'), findsOneWidget);
    expect(find.text('78% Penuh'), findsOneWidget);
    expect(find.text('Lacak Pengiriman Aktif (Truk B 9241 UZ)'), findsOneWidget);

    // Verify quick action tiles
    expect(find.text('Sertifikasi Mutu & Legalitas NIB'), findsOneWidget);
    expect(find.text('Integrasi Webhook ERP Pabrik'), findsOneWidget);
  });
}
