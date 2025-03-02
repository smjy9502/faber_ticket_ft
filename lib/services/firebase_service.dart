import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;

import '../utils/constants.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;


  Future<void> saveCustomData(Map<String, String> data) async {
    await _firestore.collection(Constants.customDataCollection).doc('user_data').set(data);
  }

  Future<String> uploadImage(html.File file) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final destination = 'images/$fileName';

    final ref = _storage.ref(destination);
    final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': fileName},
    );
    final uploadTask = ref.putBlob(file, metadata);

    final snapshot = await uploadTask.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    print('Download URL: $downloadUrl'); // 디버깅용

    return downloadUrl;
  }


  Future<Map<String, dynamic>> getCustomData() async {
    DocumentSnapshot snapshot = await _firestore.collection(Constants.customDataCollection).doc('user_data').get();
    return snapshot.data() as Map<String, dynamic>? ?? {};
  }
}
