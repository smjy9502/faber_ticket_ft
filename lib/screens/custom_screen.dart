import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'package:faber_ticket_ft/utils/constants.dart';

class CustomScreen extends StatefulWidget {
  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  final Map<String, TextEditingController> controllers = {
    'Title': TextEditingController(),
    'Release': TextEditingController(),
    'Director': TextEditingController(),
    'Cast': TextEditingController(),
    'Review': TextEditingController(),
    'Date': TextEditingController(),
    'Time': TextEditingController(),
    'Theater': TextEditingController(),
  };

  @override
  void dispose() {
    controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> saveData() async {
    Map<String, String> data = {};
    controllers.forEach((key, value) {
      data[key] = value.text;
    });

    await _firebaseService.saveCustomData(data);

    // 데이터 저장 후 사용자에게 알림
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully!')));

    // 입력 필드 초기화
    controllers.forEach((key, controller) => controller.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Screen')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...controllers.keys.map((title) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controllers[title],
                decoration: InputDecoration(labelText: title),
              ),
            )),
            ElevatedButton(onPressed: saveData, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
