import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:faber_ticket_ft/services/firebase_service.dart';
import 'package:faber_ticket_ft/utils/constants.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  List<String> imageUrls = List.filled(9, '');

  Future<void> _uploadImages() async {
    final input = html.FileUploadInputElement()..accept = 'image/*';
    input.multiple = true;
    input.click();

    await input.onChange.first;
    if (input.files!.isNotEmpty) {
      for (var i = 0; i < input.files!.length && i < 9; i++) {
        final file = input.files![i];
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        await reader.onLoad.first;

        final bytes = reader.result as Uint8List;
        final ref = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}');
        final uploadTask = ref.putData(bytes);
        final snapshot = await uploadTask;

        final downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrls[i] = downloadUrl;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (imageUrls[index].isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Dialog(
                                child: Image.network(imageUrls[index]),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: imageUrls[index].isNotEmpty
                          ? Image.network(imageUrls[index], fit: BoxFit.cover)
                          : Icon(Icons.add_photo_alternate),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text('Upload'),
                  onPressed: _uploadImages,
                ),
                ElevatedButton(
                  child: Text('Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
