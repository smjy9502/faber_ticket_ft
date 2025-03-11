import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'package:faber_ticket_ft/screens/main_screen.dart';
import 'package:faber_ticket_ft/screens/photo_screen.dart';
import 'package:faber_ticket_ft/screens/song_screen.dart';
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
      setState(() {
        controllers.forEach((key, controller) {
          controller.text = data[key] ?? '';
        });
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Constants.ticketBackImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: saveData,
                  child: Text('Save'),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Table(
                      border: TableBorder.all(),
                      children: controllers.entries.map((entry) {
                        return TableRow(
                          children: [
                            TableCell(child: Center(child: Text(entry.key))),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(controller: entry.value),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SongScreen()),
                      );
                    },
                    child: Text('SetList'),
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
            ],
          ),
        ),
      ),
    );
  }
}
