// import 'dart:html';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class FileUploadSample extends StatefulWidget {
//   const FileUploadSample({super.key});
//
//   @override
//   State<FileUploadSample> createState() => _FileUploadSampleState();
// }
//
// class _FileUploadSampleState extends State<FileUploadSample> {
//   String? imageUrl;
//   uploadImage() async {
//     final _firebaseStorage = FirebaseStorage.instance;
//     final _imagePicker = ImagePicker();
//     PickedFile image;
//     //Check Permissions
//     await Permission.photos.request();
//
//     var permissionStatus = await Permission.photos.status;
//
//     if (permissionStatus.isGranted) {
//       //Select Image
//       image = await _imagePicker.getImage(source: ImageSource.gallery);
//       var file = File(image.path);
//
//       if (image != null) {
//         //Upload to Firebase
//         var snapshot = await _firebaseStorage
//             .ref()
//             .child('images/imageName')
//             .putFile(file)
//             .onComplete;
//         var downloadUrl = await snapshot.ref.getDownloadURL();
//         setState(() {
//           imageUrl = downloadUrl;
//         });
//       } else {
//         print('No Image Path Received');
//       }
//     } else {
//       print('Permission not granted. Try Again with permission access');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         centerTitle: true,
//         title: Text("File Upload"),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             Container(
//                 margin: EdgeInsets.all(15),
//                 padding: EdgeInsets.all(15),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(15),
//                   ),
//                   border: Border.all(color: Colors.white),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       offset: Offset(2, 2),
//                       spreadRadius: 2,
//                       blurRadius: 1,
//                     ),
//                   ],
//                 ),
//                 child: (imageUrl != null)
//                     ? Image.network(imageUrl!)
//                     : Image.network('https://i.imgur.com/sUFH1Aq.png')),
//             ElevatedButton(
//                 onPressed: () {
//                   uploadImage();
//                 },
//                 child: Text("Upload file"))
//           ],
//         ),
//       ),
//     );
//   }
// }