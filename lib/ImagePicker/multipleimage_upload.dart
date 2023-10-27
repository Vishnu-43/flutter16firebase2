import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImageUpload extends StatefulWidget {
  const MultipleImageUpload({Key? key}) : super(key: key);

  @override
  State<MultipleImageUpload> createState() => _MultipleImageUploadState();
}

class _MultipleImageUploadState extends State<MultipleImageUpload> {
  bool? permissionGranted;
  List<String> imageUrls = []; // Use a list to store multiple image URLs
  final _firebaseStorage = FirebaseStorage.instance;

  _getFromGallery() async {
    try {
      final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage(
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (pickedFiles != null) {
        for (XFile pickedFile in pickedFiles) {
          File imageFile = File(pickedFile.path);
          // You can use the 'imageFile' here for further processing or display.
          UploadTask uploadTask = _firebaseStorage
              .ref()
              .child('images/image${DateTime.now()}.jpg')
              .putFile(imageFile);

          TaskSnapshot snapshot = await uploadTask.whenComplete(() => {});
          var downloadUrl = await snapshot.ref.getDownloadURL();
          setState(() {
            imageUrls.add(downloadUrl); // Add the URL to the list
          });
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getFromGallery();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission handler'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              _getFromGallery();
            },
            child: Text('Request Storage Permission'),
          ),
          // Display all uploaded images
          Column(
            children: imageUrls.map((url) {
              return Container(
                width: 200, // Set your desired width
                height: 200, // Set your desired height
                child: Image.network(url),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}