import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/negotiation/screens/new_negotiation_screen.dart';

void main() {
  testWidgets('NewNegotiationScreen renders all Figma components and calculates dynamically',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: NewNegotiationScreen(),
      ),
    );

    // 1. Verify App Bar and Header
    expect(find.text('Mulai Negosiasi Baru'), findsOneWidget);
    expect(find.text('Plastik PET Bening Cacah Grade A'), findsNWidgets(2)); // in appbar & card

    // 2. Verify Step Indicator
    expect(find.text('Formulir LOI Resmi'), findsOneWidget);
    expect(find.text('• Step 1 dari 2'), findsOneWidget);

    // 3. Verify Partner and Baseline Card
    expect(find.text('Komoditas & Mitra Terpilih'), findsOneWidget);
    expect(find.text('PT Daur Alam Lestari'), findsOneWidget);
    expect(find.text('NIB Verified'), findsOneWidget);
    expect(find.text('Rp 11.200'), findsOneWidget);

    // 4. Verify Tonnage and Price Card
    expect(find.text('Kuantitas & Penawaran Harga'), findsOneWidget);
    expect(find.text('= 8.000 kg'), findsOneWidget);
    expect(find.text('+2.7% dari acuan'), findsOneWidget);

    // 5. Verify Calculation Box (8.000 kg x 11.500 = 92.000.000)
    expect(find.text('Kalkulasi Volume'), findsOneWidget);
    expect(find.text('8.000 kg × Rp 11.500'), findsOneWidget);
    expect(find.text('ESTIMASI NILAI TRANSAKSI'), findsOneWidget);
    expect(find.text('Rp 92.000.000'), findsOneWidget);

    // 6. Verify Delivery and Schedule Card
    expect(find.text('Opsi Pengiriman & Jadwal'), findsOneWidget);
    expect(find.text('Franco Gudang'), findsOneWidget);
    expect(find.text('FOB (Ambil Sendiri)'), findsOneWidget);
    expect(find.text('10/06/2026'), findsOneWidget);

    // Toggle delivery option
    await tester.tap(find.text('FOB (Ambil Sendiri)'));
    await tester.pump();

    // 7. Verify Technical Specs
    expect(find.text('Catatan Spesifikasi Teknis'), findsOneWidget);
    expect(find.text('≤ 1.0 % toleransi'), findsOneWidget);
    expect(find.text('≤ 0.5 % max impuritas'), findsOneWidget);

    // 8. Verify CTA Button & Confirmation Dialog
    final ctaButton = find.text('Kirim Penawaran Awal');
    expect(ctaButton, findsOneWidget);
    await tester.ensureVisible(ctaButton);
    await tester.tap(ctaButton);
    await tester.pumpAndSettle();

    expect(find.text('Kirim Penawaran Awal (LOI)'), findsOneWidget);
    expect(find.text('Konfirmasi & Kirim'), findsOneWidget);
  });
}
