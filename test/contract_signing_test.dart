import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/transaction/screens/contract_signing_screen.dart';

void main() {
  testWidgets('ContractSigningScreen renders all contract clauses and e-sign workflow',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: ContractSigningScreen(),
      ),
    );

    // 1. Verify Top App Bar
    expect(find.text('Pengesahan Kontrak Digital'), findsOneWidget);
    expect(find.text('MoA-2026/OCC-941'), findsOneWidget);

    // 2. Verify Document Title & Akta Metadata
    expect(find.text('Memorandum of Agreement Jual–Beli Komoditas'),
        findsOneWidget);
    expect(find.text('CTR/WH-2026/IX/8941'), findsOneWidget);
    expect(find.text('30 September 2026'), findsOneWidget);

    // 3. Verify Commodity Banner Text
    expect(find.text('Kardus Bekas (OCC) Sortir Bal Super'), findsOneWidget);
    expect(find.text('Grade A\nIndustri'), findsOneWidget);

    // 4. Verify Signatory Parties
    expect(find.text('PT Daurindo Jaya'), findsNWidgets(2)); // Pihak I & E-Sign
    expect(find.text('NIB: 9120004928182'), findsOneWidget);
    expect(find.text('Pembeli Terverifikasi'), findsNWidgets(2)); // Pihak II & E-Sign
    expect(find.text('ID: IND-BYR-7729'), findsOneWidget);

    // 5. Verify Clauses and Total
    expect(find.text('Pasal Kuantitas Bersih'), findsOneWidget);
    expect(find.text('5.000 kg'), findsOneWidget);
    expect(find.text('Toleransi Kadar Air'), findsOneWidget);
    expect(find.text('Maks. 9%'), findsOneWidget);
    expect(find.text('Harga Satuan Terikat'), findsOneWidget);
    expect(find.text('10.250.000'), findsOneWidget);
    expect(find.text('Sepuluh Juta Dua Ratus Lima Puluh Ribu Rupiah'),
        findsOneWidget);

    // 6. Verify Digital Signatures Area
    expect(find.text('AREA TANDA TANGAN DIGITAL (E-SIGN)'), findsOneWidget);
    expect(find.text('SIAP DITEKEN'), findsOneWidget);
    expect(find.text('TERTANDATANGANI'), findsOneWidget);
    expect(find.text('Menunggu e-Sign Anda'), findsOneWidget);

    // 7. Verify Sticky Button
    final signBtn = find.text('Tandatangani Kontrak');
    expect(signBtn, findsOneWidget);

    // 8. Test Tap Action opens Bottom Sheet
    await tester.tap(signBtn);
    await tester.pumpAndSettle();
    expect(find.text('Otorisasi Tanda Tangan Digital'), findsOneWidget);
    expect(find.text('Konfirmasi & Bubuhkan e-Sign'), findsOneWidget);
  });
}
