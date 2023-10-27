import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter16firebase2/EmailValidation/loginform.dart';
import 'package:flutter16firebase2/ImagePicker/image_picker.dart';
import 'package:flutter16firebase2/ImagePicker/multipleimage_upload.dart';


// import 'PhoneNumber/home.dart';
// import 'PhoneNumber/phonenumberauth.dart';
// import 'PhoneNumber/verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
         home: LoginForm(),
        );
  }
}