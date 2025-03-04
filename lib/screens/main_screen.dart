import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/screens/custom_screen.dart';
import 'package:faber_ticket_ft/screens/song_screen.dart';
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
        final uid = await _firebaseService.getOrCreateUID();
        bool isValid = await _firebaseService.verifyAccess(uid);
        if (isValid) {
          print('Access granted, staying on MainScreen');
        } else {
          print('Access denied, navigating to ErrorScreen');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CustomScreen()),
            );
          }
        },
        child: LayoutBuilder(
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: SizedBox()),
                    CustomButton(
                      image: Constants.buttonSetlistImage,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SongScreen()),
                        );
                      },
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                    ),
                    SizedBox(height: Constants.paddingLarge),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
