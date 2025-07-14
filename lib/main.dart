import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flowdeck/core/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (placeholder config)
  await Firebase.initializeApp();

  runApp(
    const ProviderScope(
      child: FlowDeckApp(),
    ),
  );
}
