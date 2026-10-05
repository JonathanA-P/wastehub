import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/notifications/screens/notification_center_screen.dart';

void main() {
  testWidgets('NotificationCenterScreen renders notifications and filter chips',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: NotificationCenterScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Title & Filter Chips
    expect(find.text('Pusat Notifikasi'), findsOneWidget);
    expect(find.text('Semua'), findsOneWidget);
    expect(find.text('Pengiriman'), findsOneWidget);
    expect(find.text('Negosiasi'), findsOneWidget);

    // Verify notification titles
    expect(find.text('Truk B 9241 UZ Mendekati Gerbang Bitung'), findsOneWidget);
    expect(find.text('Counter Offer Diterima (#OF-441)'), findsOneWidget);

    // Filter to 'Pengiriman'
    await tester.tap(find.text('Pengiriman'));
    await tester.pumpAndSettle();

    expect(find.text('Truk B 9241 UZ Mendekati Gerbang Bitung'), findsOneWidget);
    expect(find.text('Counter Offer Diterima (#OF-441)'), findsNothing);

    // Mark all as read
    await tester.tap(find.text('Tandai Dibaca'));
    await tester.pump();
  });
}
