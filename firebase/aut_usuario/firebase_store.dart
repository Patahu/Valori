

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class DataBaseIncidentFirestore {
  final FirebaseStorage _firebaseFirestore;

  DataBaseIncidentFirestore({FirebaseStorage? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseStorage.instance;

  UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = _firebaseFirestore.ref().child(destination);

      return ref.putFile(file);
    } catch (e) {
      print("OCURRIO UN PROBLEMA");
      return null;
    }
  }
}