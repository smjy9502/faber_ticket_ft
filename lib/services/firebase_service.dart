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
      if (userDoc.exists) {
        // NFC 칩을 통해 접속했는지 확인하는 로직 추가
        // 예: 특정 쿠키나 세션 정보를 확인
        // 아래는 예시 코드입니다. 실제 환경에 맞게 수정해야 합니다.
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

  Future<void> saveCustomData(Map<String, String> data) async {
    final uid = await getOrCreateUID();
    await _firestore.collection('users').doc(uid).set({
      'createdAt': DateTime.now(),
      'customData': data, // 이 부분을 추가
    }, SetOptions(merge: true));
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
