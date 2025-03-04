import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/screens/custom_screen.dart';
import 'package:faber_ticket_ft/screens/song_screen.dart';
import 'package:faber_ticket_ft/widgets/custom_button.dart';
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'error_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    setNFCFlag();
    checkAccess();
  }

  // NFC 칩 접속 시 'isFromNFC' 값을 'true'로 설정
  Future<void> setNFCFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFromNFC', true);
  }


  Future<void> checkAccess() async {
    try {
      final uid = await _firebaseService.getOrCreateUID();
      print('UID: $uid'); // UID 로깅

      bool isValid = await _firebaseService.verifyAccess(uid);
      print('isValid: $isValid'); // 유효성 로깅

      if (!isValid) {
        print('Access denied, navigating to ErrorScreen'); // 접근 거부 로깅
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ErrorScreen()),
        );
      } else {
        print('Access granted, staying on MainScreen'); // 접근 허용 로깅
      }
    } catch (e) {
      print('Error checking access: $e'); // 오류 로깅
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
