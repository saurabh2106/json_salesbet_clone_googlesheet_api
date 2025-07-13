import 'package:flutter/material.dart';
import 'package:json_salesbet/dyanamic_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SalesBets JSON UI',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const DynamicUIScreen(),
    );
  }
}
