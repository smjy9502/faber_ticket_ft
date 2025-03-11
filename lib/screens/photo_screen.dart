import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:faber_ticket_ft/screens/custom_screen.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  List<String> imageUrls = List.filled(9, '');

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    final data = await _firebaseService.getCustomData();
    if (data['imageUrls'] != null) {
      setState(() {
        imageUrls = List.from(data['imageUrls']);
      });
    }
  }

  Future<void> uploadImages() async {
    try {
      final input = html.FileUploadInputElement()..accept = "image/*";
      input.multiple = true;
      input.click();

      await input.onChange.first;
      if (input.files!.isNotEmpty) {
        for (var i = 0; i < input.files!.length && i < imageUrls.length; i++) {
          final file = input.files![i];
          final downloadUrl = await _firebaseService.uploadImage(file);
          setState(() {
            imageUrls[i] = downloadUrl;
          });
        }
        await saveImages();
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<void> saveImages() async {
    await _firebaseService.saveCustomData({'imageUrls': imageUrls});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Constants.photoBackgroundImage),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CustomScreen()),
                );
              },
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        if (imageUrls[index].isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(child: Image.network(imageUrls[index])),
                          );
                        }
                      },
                      child: Container(
                        decoration:
                        BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
                        child:
                        imageUrls[index].isNotEmpty ? Image.network(imageUrls[index], fit BoxFit.cover) : Icon(Icons.add_photo_alternate),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text('Upload'),
                  onPressed: uploadImages,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
