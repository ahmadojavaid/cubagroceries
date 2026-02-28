import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: CubaGroceriesApp(),
    ),
  );
}

class CubaGroceriesApp extends StatelessWidget {
  const CubaGroceriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuba Groceries',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const Scaffold(
        body: Center(
          child: Text('Cuba Groceries'),
        ),
      ),
    );
  }
}
