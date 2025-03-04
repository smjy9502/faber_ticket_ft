import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;

  Future<String> getOrCreateUID() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('user_uid');
    if (uid == null) {
      uid = Uuid().v4();
      await prefs.setString('user_uid', uid);
      await _firestore.collection('users').doc(uid).set({'createdAt': FieldValue.serverTimestamp()});
    }
    return uid;
  }

  Future<bool> verifyAccess(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final prefs = await SharedPreferences.getInstance();
        bool isFromNFC = prefs.getBool('isFromNFC') ?? false;
        return isFromNFC;
      } else {
        return false;
      }
    } catch (e) {
      print('Error verifying access: $e');
      return false;
    }
  }

  Future<void> saveCustomData(Map<String, dynamic> data) async {
    final uid = await getOrCreateUID();
    await _firestore.collection('users').doc(uid).set({
      'customData': data,
      'lastUpdated': FieldValue.serverTimestamp()
    }, SetOptions(merge: true));
  }

  Future<String> uploadImage(html.File file) async {
    final uid = await getOrCreateUID();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
    final destination = 'images/$uid/$fileName';
    final ref = _storage.ref(destination);
    final uploadTask = ref.putBlob(file);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<Map<String, dynamic>> getCustomData() async {
    final uid = await getOrCreateUID();
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data()?['customData'] ?? {};
  }
}
