import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show ProviderObserver, ProviderScope;
import 'package:network_demo/_features.dart';

void main() {
  runApp(
    const ProviderScope(
      observers: kDebugMode ? <ProviderObserver>[AppObserver()] : null,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Network Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(title: 'Network'),
    );
  }
}
