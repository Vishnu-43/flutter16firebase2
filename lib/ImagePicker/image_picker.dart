import 'dart:io';
// import 'dart:js_interop';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PermissionHandler extends StatefulWidget {
  const PermissionHandler({super.key});

  @override
  State<PermissionHandler> createState() => _PermissionHandlerState();
}

class _PermissionHandlerState extends State<PermissionHandler> {
  bool? permissionGraned;
  String? imageUrl;
  List<UploadTask> _UploadTask = [];
  final _firebaseStorage = FirebaseStorage.instance;

  _getFromGallary() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        UploadTask uploadTask =
            _firebaseStorage.ref().child("images/imageName").putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask.whenComplete(() => () {});
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('permission'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _getFromGallary();
            },
            child: Text("Request stroage Permission"),
          ),
          Center(
            child: Container(
              width: 200, // Set your desired width
               height: 200, // Set your desired height
               child: (imageUrl != null) ? Image.network(imageUrl!) : Image.network('gs://flutter16firebase2.appspot.com'),
            ),
          )
        ],
      ),
    );
  }
}
