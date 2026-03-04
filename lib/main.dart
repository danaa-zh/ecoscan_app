import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'core/utils/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (_) {
    // .env optional
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.collection('test').add({
  'hello': 'world',
});

  AppLog.i('Firebase initialized');

  runApp(const EcoScanApp());
}