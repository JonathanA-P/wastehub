import 'package:flutter_test/flutter_test.dart';
import 'package:wastehub/main.dart';

void main() {
  testWidgets('WasteHub catalog and navigation bar smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const WasteHubApp());

    // Verify brand title and header
    expect(find.text('WasteHub'), findsOneWidget);
    expect(find.text('Katalog Komoditas Daur'), findsOneWidget);
    expect(find.text('PERMINTAAN AKTIF'), findsOneWidget);
    expect(find.text('1.480'), findsOneWidget);

    // Verify bottom navigation items
    expect(find.text('Pasar'), findsOneWidget);
    expect(find.text('Kontrak'), findsOneWidget);
    expect(find.text('Inbox'), findsOneWidget);
    expect(find.text('Bisnis'), findsOneWidget);
  });
}
