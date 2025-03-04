import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:faber_ticket_ft/screens/photo_screen.dart';

class CustomScreen extends StatefulWidget {
  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  // TextEditingController를 위한 맵 생성
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
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> saveData() async {
    try {
      Map<String, String> data = {};
      controllers.forEach((key, value) {
        data[key] = value.text;
      });
      await _firebaseService.saveCustomData(data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully!')));
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving data: $e')));
    }
  }

  Future<void> loadData() async {
    try {
      final data = await _firebaseService.getCustomData();
      controllers.forEach((key, controller) {
        controller.text = data[key] ?? '';
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Screen')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.ticketBackImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              columnWidths: {0: FixedColumnWidth(100), 1: FlexColumnWidth()},
              border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(children: [
                  TableCell(child: Center(child: Text('Title'))),
                  TableCell(child:
                  Padding(padding:
                  const EdgeInsets.all(8.0),
                    child:
                    TextField(controller:
                    controllers['Title']),
                  )),
                ]),
                // 나머지 필드도 동일하게 추가...
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
      BottomAppBar(child:
      Row(mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,
        children:[
          ElevatedButton(onPressed:
          saveData, child:
          Text('Save')),
          ElevatedButton(onPressed:
              () { Navigator.push(context,
              MaterialPageRoute(builder:
                  (context) => PhotoScreen())); },
              child:
              Text('Photo')),
        ],
      )),
    );
  }
}
