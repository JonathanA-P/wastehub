import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/transaction/screens/bast_digital_screen.dart';

void main() {
  testWidgets('BastDigitalScreen renders BAST document, Sucofindo QC, and settlement',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: BastDigitalScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Title & Number
    expect(find.text('Berita Acara Serah Terima (BAST)'), findsOneWidget);
    expect(find.text('BAST-2026/DAL/0790'), findsOneWidget);

    // Verify Parties
    expect(find.text('PT Sinar Logam'), findsOneWidget);
    expect(find.text('PT WasteHub Circular Indonesia'), findsOneWidget);

    // Verify QC Sucofindo
    expect(find.text('Hasil Uji Mutu Laboratorium Sucofindo'), findsOneWidget);
    expect(find.text('GRADE A (PASS)'), findsOneWidget);
    expect(find.text('96.4%'), findsOneWidget);

    // Verify Escrow Settlement
    expect(find.text('Pencairan Dana Rekening Bersama (Escrow)'), findsOneWidget);
    expect(find.text('SETTLED'), findsOneWidget);
    expect(find.text('Rp 59.103.000'), findsOneWidget);

    // Verify Signatures
    expect(find.text('Bambang Hermawan'), findsOneWidget);
    expect(find.text('Siti Rahmawati'), findsOneWidget);
  });
}
