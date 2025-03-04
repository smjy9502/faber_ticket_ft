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
    Map<String, String> data = {};
    controllers.forEach((key, value) {
      data[key] = value.text;
    });
    await _firebaseService.saveCustomData(data);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved successfully!')));
  }

  Future<void> loadData() async {
    final data = await _firebaseService.getCustomData();
    controllers.forEach((key, controller) {
      controller.text = data[key] ?? '';
    });
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
              columnWidths: {
                0: FixedColumnWidth(100),
                1: FlexColumnWidth(),
              },
              border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Title'))),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(controller: controllers['Title']),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Release'))),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(controller: controllers['Release']),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Director'))),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(controller: controllers['Director']),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Cast'))),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(controller: controllers['Cast']),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Review'))),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(controller: controllers['Review']),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Date'))),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(controller: controllers['Date']),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Time'))),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(controller: controllers['Time']),
                    )),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: Center(child: Text('Theater'))),
                    TableCell(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(controller: controllers['Theater']),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: saveData,
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhotoScreen()),
                );
              },
              child: Text('Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
