import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/transaction/screens/transaction_success_screen.dart';

void main() {
  testWidgets('TransactionSuccessScreen renders all Figma components and triggers actions',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: TransactionSuccessScreen(),
      ),
    );

    // 1. Verify App Bar
    expect(find.text('RINCIAN TRANSAKSI'), findsOneWidget);
    expect(find.text('Surat Jalan Digital & SPK'), findsOneWidget);
    expect(find.text('WH'), findsOneWidget);

    // 2. Verify Success Banner
    expect(find.text('Transaksi Berhasil'), findsOneWidget);
    expect(find.text('WH-CTR-2026-8941'), findsOneWidget);
    expect(find.text('SPK-0842/WH/X'), findsOneWidget);

    // 3. Verify Cycle Stepper (Tahap 3 dari 5)
    expect(find.text('PROGRES SIKLUS TRANSAKSI'), findsOneWidget);
    expect(find.text('Tahap 3 dari 5'), findsOneWidget);
    expect(find.text('1. Negosiasi & Toleransi'), findsOneWidget);
    expect(find.text('2. Pengesahan SPK & Kontrak'), findsOneWidget);
    expect(find.text('3. Pembayaran Diterima'), findsOneWidget);
    expect(find.text('Dana Terverifikasi'), findsOneWidget);
    expect(find.text('4. Logistik Armada & Timbang'), findsOneWidget);
    expect(find.text('Jadwal: 03 Okt 2026'), findsOneWidget);
    expect(find.text('5. Pencairan Otomatis'), findsOneWidget);

    // 4. Verify Surat Jalan Digital (e-DO) & QR Token
    expect(find.text('Surat Jalan Digital (e-DO)'), findsOneWidget);
    expect(find.text('#eDO-2026-X81-JKT'), findsOneWidget);
    expect(find.text('Siap Scan'), findsOneWidget);
    expect(find.text('TOKEN AKSES GERBANG & TIMBANGAN'), findsOneWidget);
    expect(find.text('DO-TOKEN: 8A29-CX-2826'), findsOneWidget);

    // 5. Verify Logistics Details (Truck & Driver)
    expect(find.text('ARMADA PENGANGKUT'), findsOneWidget);
    expect(find.text('Truk Tronton / Fuso Wingbox'), findsOneWidget);
    expect(find.text('B 9481 UXT'), findsOneWidget);
    expect(find.text('PENGEMUDI DITUGASKAN'), findsOneWidget);
    expect(find.text('Bambang Susilo'), findsOneWidget);
    expect(find.text('DRV-8810-ID'), findsOneWidget);

    // 6. Verify Commodity Specs & Total Contract Value
    expect(find.text('SPESIFIKASI KOMODITAS'), findsOneWidget);
    expect(find.text('Kardus OCC Bal Kering (Grade A)'), findsOneWidget);
    expect(find.text('5.000 kg (5,00 Ton)'), findsOneWidget);
    expect(find.text('Rp 2.050 / kg'), findsOneWidget);
    expect(find.text('Total Nilai Kontrak'), findsOneWidget);
    expect(find.text('Rp 10.250.000'), findsNWidgets(2)); // in step 3 and contract total

    // 7. Verify Sticky Buttons & Tap actions
    final unduhBtn = find.text('Unduh e-DO & Kontrak PDF');
    expect(unduhBtn, findsOneWidget);
    await tester.ensureVisible(unduhBtn);
    await tester.tap(unduhBtn);
    await tester.pump();

    final pantauBtn = find.text('Pantau Logistik');
    expect(pantauBtn, findsOneWidget);
    await tester.ensureVisible(pantauBtn);
    await tester.tap(pantauBtn);
    await tester.pump();
  });
}
