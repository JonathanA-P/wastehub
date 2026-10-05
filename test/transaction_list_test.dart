import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/transaction/screens/transaction_list_screen.dart';

void main() {
  testWidgets('TransactionListScreen renders KPI, search, chips, and transaction contract cards',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: TransactionListScreen(),
      ),
    );

    // 1. Verify Top App Bar
    expect(find.text('Daftar Transaksi & Kontrak'), findsOneWidget);
    expect(find.text('WH'), findsOneWidget);
    expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);

    // 2. Verify + Kontrak Baru button
    expect(find.text('+ Kontrak Baru'), findsOneWidget);

    // 3. Verify KPI Summary Card
    expect(find.text('Total Tonase Sirkular'), findsOneWidget);
    expect(find.text('48,5'), findsOneWidget);
    expect(find.text('Ton'), findsOneWidget);
    expect(find.text('+12.4% vs bln lalu'), findsOneWidget);

    // 4. Verify Search & Filter Chips
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Semua (22)'), findsOneWidget);
    expect(find.text('Aktif / Logistik (4)'), findsOneWidget);
    expect(find.text('Selesai (17)'), findsOneWidget);
    expect(find.text('Dibatalkan (1)', skipOffstage: false), findsOneWidget);

    // 5. Verify Transaction Cards
    expect(find.text('#WH-CTR-2026-0941'), findsOneWidget);
    expect(find.text('Kardus Bekas OCC Bal'), findsOneWidget);
    expect(find.text('Armada Menuju Timbangan'), findsOneWidget);
    expect(find.text('Lihat e-DO & QR →'), findsOneWidget);

    expect(find.text('#WH-CTR-2026-0812'), findsOneWidget);
    expect(find.text('Plastik PET Bening Cacah'), findsOneWidget);
    expect(find.text('Rincian Kontrak →'), findsOneWidget);

    expect(find.text('#WH-CTR-2026-0790'), findsOneWidget);
    expect(find.text('Scrap Aluminium Kaleng UBC'), findsOneWidget);
    expect(find.text('Selesai & Dicairkan'), findsOneWidget);
    expect(find.text('Unduh BAST Digital →'), findsOneWidget);

    // 6. Test Search Filtering
    await tester.enterText(find.byType(TextField), 'Kardus Bekas');
    await tester.pump();
    expect(find.text('Kardus Bekas OCC Bal'), findsOneWidget);
    expect(find.text('Plastik PET Bening Cacah'), findsNothing);

    // Clear search
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();
    expect(find.text('Plastik PET Bening Cacah'), findsOneWidget);

    // 7. Test Filter Chip Selection
    await tester.tap(find.text('Aktif / Logistik (4)'));
    await tester.pump();
    expect(find.text('Kardus Bekas OCC Bal'), findsOneWidget);
    expect(find.text('Plastik PET Bening Cacah'), findsNothing);
  });
}
