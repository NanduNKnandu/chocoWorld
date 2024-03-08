import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final CollectionReference sliderCollection =
  FirebaseFirestore.instance.collection('slider');

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> getSliderImages() async {
    QuerySnapshot sliderSnapshot = await sliderCollection.get();

    return sliderSnapshot.docs
        .map((doc) => doc['imageUrl'] as String)
        .toList();
  }

  Future<void> addSliderImage(String imageUrl) async {
    await sliderCollection.add({'imageUrl': imageUrl});
  }

  Future<String> uploadImage(String filePath) async {
    try {
      File file = File(filePath);

      // Create a reference to the location you want to upload to in Firebase Storage
      Reference storageReference =
      _storage.ref().child('slider_images/${DateTime.now().toString()}');

      // Upload the file to Firebase Storage
      await storageReference.putFile(file);

      // Get the download URL
      String downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Error uploading image');
    }
  }
}
