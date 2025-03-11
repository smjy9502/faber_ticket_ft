import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

import 'package:faber_ticket_ft/screens/main_screen.dart';
import 'package:faber_ticket_ft/screens/error_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;


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
      home: FutureBuilder(
        future: checkInitialAccess(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.data == true) {
            return MainScreen();
          } else {
            return ErrorScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<bool> checkInitialAccess() async {
  if (foundation.kIsWeb) {
    final userAgent = html.window.navigator.userAgent;
    final isMobile = userAgent.contains('Mobile');

    if (isMobile) {
      // 모바일 기기에서만 접속 허용
      return true;
    } else {
      return false;
    }
  } else {
    // 모바일 앱에서는 NFC 기능을 사용하여 접속 제한
    final prefs = await SharedPreferences.getInstance();
    bool isFromNFC = prefs.getBool('isFromNFC') ?? false;
    if (isFromNFC) {
      await prefs.setBool('isFromNFC', false);
      print("NFC flag reset");
      return true;
    } else {
      return false;
    }
  }
}
