import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/negotiation/screens/negotiation_chat_screen.dart';

void main() {
  testWidgets('NegotiationChatScreen renders chat bubbles, embedded offer, and triggers actions',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: NegotiationChatScreen(),
      ),
    );

    // 1. Verify App Bar
    expect(find.text('DA'), findsOneWidget);
    expect(find.text('PT Daur Alam Lestari'), findsOneWidget);
    expect(find.text('Verified NIB'), findsOneWidget);
    expect(find.text('• Online'), findsOneWidget);

    // 2. Verify Sub-header
    expect(find.text('Franco Gudang'), findsOneWidget);

    // 3. Verify Messages
    expect(find.textContaining('Selamat pagi rekan Industri'), findsOneWidget);
    expect(find.textContaining('Pagi PT Daur Alam'), findsOneWidget);
    expect(find.text('COA_PET_Flakes_Lot882.pdf'), findsOneWidget);

    // 4. Verify Embedded Offer Card
    expect(find.text('RINCIAN PENAWARAN'), findsOneWidget);
    expect(find.text('KADALUWARSA 02:45:00'), findsOneWidget);
    expect(find.text('8.000 kg (8 Ton)'), findsOneWidget);
    expect(find.text('HARGA SATUAN'), findsOneWidget);
    expect(find.text('Rp 11.500 /kg'), findsOneWidget);
    expect(find.text('TOTAL NILAI KONTRAK'), findsOneWidget);
    expect(find.text('Rp 92.000.000'), findsOneWidget);
    expect(find.text('Franco Gudang Pembeli (Tangerang)'), findsOneWidget);

    // 5. Verify Dual Action Buttons
    final counterBtn = find.text('Ajukan Counter Offer');
    expect(counterBtn, findsOneWidget);

    final agreeBtn = find.text('Sepakati Harga');
    expect(agreeBtn, findsOneWidget);

    // 6. Test sending a message
    await tester.enterText(
        find.byType(TextField), 'Siap, terima kasih konfirmasinya.');
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.text('Siap, terima kasih konfirmasinya.', skipOffstage: false), findsOneWidget);

    // 7. Test tapping Sepakati Harga opens dialog
    await tester.tap(agreeBtn);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.text('Sepakati Harga & Terbitkan Kontrak'), findsOneWidget);
    expect(find.text('Ya, Sepakati'), findsOneWidget);
  });
}
