import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/features/profile/screens/user_profile_screen.dart';

void main() {
  testWidgets('UserProfileScreen renders company details, NIB, and legal certifications',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: UserProfileScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify company name & NIB
    expect(find.text('PT Circular Recycler Indonesia'), findsOneWidget);
    expect(find.text('9120003418902'), findsOneWidget);
    expect(find.text('Terverifikasi Berisiko Menengah-Tinggi'), findsOneWidget);

    // Verify PIC Credentials
    expect(find.text('Budi Santoso, ST'), findsOneWidget);
    expect(find.text('procurement@circular-recycler.co.id'), findsOneWidget);

    // Verify KLHK & ISO Certifications
    expect(find.textContaining('KLHK RI'), findsOneWidget);
    expect(find.textContaining('ISO 14001:2015'), findsOneWidget);

    // Verify Digital Signatures
    expect(find.text('Sertifikat Digital PrivyID / Peruri'), findsOneWidget);
    expect(find.text('AKTIF'), findsOneWidget);
  });
}
