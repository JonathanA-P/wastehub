import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/negotiation/screens/counter_offer_screen.dart';

void main() {
  testWidgets('CounterOfferScreen renders all Figma components and calculates dynamically',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: CounterOfferScreen(),
      ),
    );

    // Verify Header & Batch ID
    expect(find.text('Ruang Negosiasi'), findsOneWidget);
    expect(find.text('Batch #OF-441 • OCC Bal'), findsOneWidget);
    expect(find.text('Kedaluwarsa'), findsOneWidget);

    // Verify Partner Offer details
    expect(find.text('TAWARAN ASAL MITRA'), findsOneWidget);
    expect(find.text('PT Daurindo Jaya'), findsOneWidget);
    expect(find.text('Kardus Bekas OCC Bal Kering'), findsOneWidget);

    // Verify Counter Offer Form
    expect(find.text('FORMULIR PENYESUAIAN'), findsOneWidget);
    expect(find.text('Tawaran Balik Anda'), findsOneWidget);
    expect(find.text('Mode Tawar'), findsOneWidget);

    // Verify Initial dynamic calculation (1980 * 5000 = 9.900.000)
    expect(find.text('Total Penawaran Balik'), findsOneWidget);
    expect(find.text('Rp 9.900.000'), findsOneWidget);
    expect(find.text('Hemat Rp 350.000 (3.4%)'), findsOneWidget);

    // Test quick price chip interaction: Tap '2.000'
    final chip2000 = find.text('2.000');
    expect(chip2000, findsOneWidget);
    await tester.ensureVisible(chip2000);
    await tester.tap(chip2000);
    await tester.pump();

    // Verify updated calculation (2000 * 5000 = 10.000.000)
    expect(find.text('Rp 10.000.000'), findsOneWidget);
    expect(find.text('Hemat Rp 250.000 (2.4%)'), findsOneWidget);

    // Verify Bottom CTA button
    expect(find.text('Ajukan Counter Offer'), findsOneWidget);
    expect(find.text('Batal & Kembali ke Percakapan'), findsOneWidget);

    // Tap CTA to verify confirmation dialog
    await tester.tap(find.text('Ajukan Counter Offer'));
    await tester.pumpAndSettle();
    expect(find.text('Konfirmasi Counter Offer'), findsOneWidget);
    expect(find.text('Kirim Penawaran'), findsOneWidget);
  });
}
