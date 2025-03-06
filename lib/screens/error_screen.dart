import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/error_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Text(
              "!주의하세요!\n새로고침이나 뒤로가기를 누를시 데이터가 유실될 수 있습니다ㅜㅜ\nNFC칩을 다시 태그해주세요!!!!!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
