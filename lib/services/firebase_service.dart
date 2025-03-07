import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> getAuthenticatedUID() async {
    final user = _auth.currentUser;
    if (user == null) {
      try {
        final userCredential = await _auth.signInAnonymously();
        return userCredential.user?.uid;
      } catch (e) {
        print('Error signing in anonymously: $e');
        return null;
      }
    }
    return user.uid;
  }


  Future<String> getOrCreateUID() async {
    final uid = await getAuthenticatedUID();
    if (uid != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_uid', uid);
      await _firestore.collection('users').doc(uid).set({'createdAt': FieldValue.serverTimestamp()}, SetOptions(merge: true));
      return uid;
    } else {
      throw Exception('Failed to get or create UID');
    }
  }

  Future<bool> verifyAccess(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        final prefs = await SharedPreferences.getInstance();
        bool isFromNFC = prefs.getBool('isFromNFC') ?? false;
        return isFromNFC;
      }
      return false;
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
    final metadata = firebase_storage.SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': fileName},
    );
    final uploadTask = ref.putBlob(file, metadata);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  Future<Map<String, dynamic>> getCustomData() async {
    final uid = await getOrCreateUID();
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(uid).get();
    if (!snapshot.exists) {
      return {};
    }
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return data['customData'] as Map<String, dynamic>? ?? {};
  }
}
