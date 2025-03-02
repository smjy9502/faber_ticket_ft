import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/screens/main_screen.dart';
import 'package:faber_ticket_ft/screens/error_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8081);
    await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faber Ticket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'CustomFont',
      ),
      home: MainScreen(),
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => ErrorScreen());
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
