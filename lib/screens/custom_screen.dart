import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'package:faber_ticket_ft/screens/photo_screen.dart';
import 'package:faber_ticket_ft/utils/constants.dart';

class CustomScreen extends StatefulWidget {
  @override
  _CustomScreenState createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
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

  int rating = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    Map<String, dynamic> savedData = await FirebaseService().getCustomData();
    setState(() {
      controllers.forEach((key, controller) {
        controller.text = savedData[key] ?? '';
      });
      rating = int.parse(savedData['Rating'] ?? '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Constants.ticketBackImage),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity! > 0) {
                          Navigator.pop(context);
                        }
                      },
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text('DAY6 Concert', style: Constants.headingStyle),
                              Table(
                                border: TableBorder.all(),
                                children: [
                                  for (var title in ['Title', 'Release', 'Director', 'Cast', 'Rating', 'Review', 'Date', 'Time', 'Theater'])
                                    TableRow(
                                      children: [
                                        TableCell(child: Padding(
                                          padding: EdgeInsets.all(Constants.paddingSmall),
                                          child: Text(title, style: Constants.bodyStyle),
                                        )),
                                        TableCell(
                                          child: title == 'Rating' ? buildRatingWidget() :
                                          Padding(
                                            padding: EdgeInsets.all(Constants.paddingSmall),
                                            child: TextField(controller: controllers[title]),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              ElevatedButton(
                                child: Text('Save'),
                                onPressed: () {
                                  Map<String, String> data = {};
                                  controllers.forEach((key, value) {
                                    data[key] = value.text;
                                  });
                                  data['Rating'] = rating.toString();
                                  FirebaseService().saveCustomData(data);
                                },
                              ),
                              ElevatedButton(
                                child: Text('Photo'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PhotoScreen()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildRatingWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              rating = index + 1;
            });
          },
        );
      }),
    );
  }
}
