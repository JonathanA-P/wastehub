import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/negotiation/screens/negotiation_inbox_screen.dart';

void main() {
  testWidgets('NegotiationInboxScreen renders all cards, search, filters, and floating button',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: NegotiationInboxScreen(),
      ),
    );

    // 1. Verify Top App Bar
    expect(find.text('Kotak Masuk Negosiasi'), findsOneWidget);
    expect(find.text('WH'), findsOneWidget);
    expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);

    // 2. Verify Search Bar & Filter Chips
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Semua (5)'), findsOneWidget);
    expect(find.text('Menunggu Respon (2)'), findsOneWidget);
    expect(find.text('Tawaran Masuk (1)'), findsOneWidget);
    expect(find.text('Tersepakati (1)', skipOffstage: false), findsOneWidget);

    // 3. Verify Negotiation Cards
    expect(find.text('PT Daur Alam Lestari'), findsOneWidget);
    expect(find.text('PT Daurindo Jaya'), findsOneWidget);
    expect(find.text('PT Sinar Logam'), findsOneWidget);
    expect(find.text('Bank Sampah Induk Makmur'), findsOneWidget);
    expect(find.text('CV Perkasa Abadi'), findsOneWidget);

    // Badges & prices
    expect(find.text('Tawaran Baru'), findsOneWidget);
    expect(find.text('Counter Offer'), findsOneWidget);
    expect(find.text('Tersepakati'), findsOneWidget);
    expect(find.text('Tawaran: Rp 11.500/kg'), findsOneWidget);
    expect(find.text('Counter: Rp 1.980/kg'), findsOneWidget);
    expect(find.text('Rp 14.200/kg'), findsOneWidget);

    // 4. Verify Floating Action Button
    expect(find.text('Buat Tawaran Baru'), findsOneWidget);

    // 5. Test Search Filter
    await tester.enterText(find.byType(TextField), 'Kardus OCC');
    await tester.pump();
    expect(find.text('PT Daurindo Jaya'), findsOneWidget);
    expect(find.text('PT Daur Alam Lestari'), findsNothing);

    // Clear search
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();
    expect(find.text('PT Daur Alam Lestari'), findsOneWidget);

    // 6. Test Filter Chip Selection
    await tester.tap(find.text('Menunggu Respon (2)'));
    await tester.pump();
    expect(find.text('PT Daur Alam Lestari'), findsOneWidget);
    expect(find.text('PT Daurindo Jaya'), findsOneWidget);
    expect(find.text('CV Perkasa Abadi'), findsNothing);
  });
}
