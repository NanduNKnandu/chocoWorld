import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../userDetail/firebaseService.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseService firebaseService = FirebaseService();
  final ImagePicker _picker = ImagePicker();
  late List<String> sliderImages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>>(
        future: firebaseService.getSliderImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            sliderImages = snapshot.data!;
            return ListView.builder(
              itemCount: sliderImages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Image.network(sliderImages[index]),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _pickImageFromGallery();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      String imageUrl = await firebaseService.uploadImage(pickedImage.path);
      setState(() {
        sliderImages.add(imageUrl);
      });
    }
  }
}
