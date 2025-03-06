import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/screens/main_screen.dart';
import 'package:faber_ticket_ft/screens/error_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: FutureBuilder<bool>(
        future: checkNFCAccess(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.data == true) {
            print('NFC access granted');
            return MainScreen();
          } else {
            print('NFC access denied');
            return ErrorScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<bool> checkNFCAccess() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool isFromNFC = prefs.getBool('isFromNFC') ?? false;
      print('isFromNFC: $isFromNFC');
      return isFromNFC;
    } catch (e) {
      print('Error checking NFC access: $e');
      return false;
    }
  }
}

