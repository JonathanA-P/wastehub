import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/catalog/screens/catalog_screen.dart';

void main() {
  runApp(const WasteHubApp());
}

class WasteHubApp extends StatelessWidget {
  const WasteHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WasteHub Marketplace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const CatalogScreen(),
    );
  }
}
