import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/screens/custom_screen.dart';
import 'package:faber_ticket_ft/widgets/custom_button.dart';
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:universal_html/html.dart' as html;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    // checkNFCAccess();
  }

  Future setNFCFlag() async {
    if (kIsWeb) {
      html.window.localStorage['isFromNFC'] = 'true';
      print("NFC Flag set in Local Storage");
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFromNFC', true);
      print("NFC Flag set in SharedPreferences");
    }
  }

  // main_screen.dart
  Future checkNFCAccess() async {
    if (!kIsWeb) { // 모바일 기기에서만 NFC 기능 사용
      bool isAvailable = await NfcManager.instance.isAvailable();
      if (isAvailable) {
        NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
          print("NFC Tag detected!");
          await setNFCFlag();
          final prefs = await SharedPreferences.getInstance();
          bool isFromNFC = prefs.getBool('isFromNFC') ?? false;
          if (isFromNFC) {
            print("Access granted, staying on MainScreen");
            setState(() {});
          } else {
            print("Access denied, navigating to ErrorScreen");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ErrorScreen()),
            );
          }
        });
      } else {
        print('NFC not available');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ErrorScreen()),
        );
      }
    } else {
      // 웹 플랫폼에서는 다른 인증 방법 사용
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ErrorScreen()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Constants.ticketFrontImage),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(60, 25),
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomScreen()),
                      );
                    },
                    child: Text('Enter'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
