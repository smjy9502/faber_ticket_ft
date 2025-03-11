import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/screens/custom_screen.dart';
import 'package:faber_ticket_ft/widgets/custom_button.dart';
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nfc_manager/nfc_manager.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    checkNFCAccess();
  }

  Future<void> checkNFCAccess() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        print("NFC Tag detected!");
        await setNFCFlag();
        final uid = await _firebaseService.getAuthenticatedUID();
        if (uid != null) {
          bool isValid = await _firebaseService.verifyAccess(uid);
          if (isValid) {
            print('Access granted, staying on MainScreen');
            setState(() {});
          } else {
            print('Access denied, navigating to ErrorScreen');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ErrorScreen()),
            );
          }
        } else {
          print('User not authenticated');
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
  }

  Future<void> setNFCFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFromNFC', true);
    print("NFC Flag set: ${prefs.getBool('isFromNFC')}");
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
                      minimumSize: Size(150, 50),
                      backgroundColor: Colors.blue,
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
