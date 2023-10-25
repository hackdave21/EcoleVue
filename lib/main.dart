import 'package:application_parent/Preliminaires/pageAcceuil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAgzzWtLZ6Yy3iwxa_cMcEQXzn2DhENOHE",
      authDomain: "YOUR_AUTH_DOMAIN",
      projectId: "ecolevue-f09a0",
      storageBucket: "YOUR_STORAGE_BUCKET",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      appId: "1:735875457024:android:44284ff550324240d578e5",
    ),
  );
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Acceuil()));
}
