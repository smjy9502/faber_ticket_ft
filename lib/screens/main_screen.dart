import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/screens/custom_screen.dart';
import 'package:faber_ticket_ft/screens/song_screen.dart';
import 'package:faber_ticket_ft/widgets/custom_button.dart';
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'error_screen.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:html' as html;

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

  Future<void> setNFCFlag() async {
    html.window.localStorage['isFromNFC'] = 'true';
    print('NFC flag set: ${html.window.localStorage['isFromNFC']}');
  }

  Future<void> checkNFCAccess() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        await setNFCFlag();
        setState(() {}); // 화면 갱신을 위해 추가
        print('NFC tag detected and flag set');
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
