import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../utils/constants.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;

  Future<String> getOrCreateUID() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('user_uid');
    if (uid == null) {
      uid = Uuid().v4();
      await prefs.setString('user_uid', uid);
      await _firestore.collection('users').doc(uid).set({'createdAt': DateTime.now()});
    }
    return uid;
  }

  Future<bool> verifyAccess(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      return userDoc.exists;
    } catch (e) {
      print('Error verifying access: $e');
      return false;
    }
  }

  Future<void> saveCustomData(Map<String, String> data) async {
    final uid = await getOrCreateUID();
    await _firestore.collection(Constants.customDataCollection).doc(uid).set(data, SetOptions(merge: true));
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

    print('Download URL: $downloadUrl');
    return downloadUrl;
  }

  Future<Map<String, dynamic>> getCustomData() async {
    final uid = await getOrCreateUID();
    DocumentSnapshot snapshot = await _firestore.collection(Constants.customDataCollection).doc(uid).get();
    return snapshot.data() as Map<String, dynamic>? ?? {};
  }
}
