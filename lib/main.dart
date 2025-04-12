import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zinapp_v2/riverpod_app.dart';

void main() {
  // Run the app with Riverpod
  runApp(
    const ProviderScope(
      child: RiverpodApp(),
    ),
  );
}


