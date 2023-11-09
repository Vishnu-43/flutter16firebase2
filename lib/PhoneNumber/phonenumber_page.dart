import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter16firebase2/PhoneNumber/home.dart';

import 'otpvalidation.dart';


class Phone_Login_page extends StatefulWidget {
  static String verify = "";
  @override
  State<Phone_Login_page> createState() => _Phone_Login_pageState();
}

class _Phone_Login_pageState extends State<Phone_Login_page> {
  TextEditingController countryController = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';

  bool _validatePhoneNumber() {
    RegExp regex = RegExp(r'^([+][0-9]{1,3}|0)?[0-9]{10}$');
    return regex.hasMatch(_phoneNumber);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, navigate to home page
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 12, right: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Urbanist",
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Enter your phone number to proceed",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontFamily: "sans",
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 40,
                          child: TextField(
                            controller: countryController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone",
                              hintStyle: TextStyle(fontFamily: "sans"),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            onChanged: (value) {
                              phone = value;
                            },
                            validator: (String? value) {
                              _phoneNumber = value ?? '';
                              if (!_validatePhoneNumber()) {
                                return 'Enter a valid phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      // Get the currently signed-in user from Firebase Authentication
                      final User? user = FirebaseAuth.instance.currentUser;

// Create a reference to the Firestore collection where user information will be stored
                      final CollectionReference usersRef =
                      FirebaseFirestore.instance.collection('users');

// Create a document with the user's ID as the document ID, and set the user's phone number as a field in the document
                      await usersRef.doc(user?.uid).set({
                        'phoneNumber': user?.phoneNumber,
                      });

                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: '${countryController.text + phone}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          Phone_Login_page.verify = verificationId;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Otp_Screen();
                              },
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "sans",
                          fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "By clicking “Continue”, I agree to Terms and Conditions, \n                 Privacy Policy, and Service Agreement",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Urbanist",
                    fontSize: 11,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "OR",
                  style: TextStyle(fontFamily: "lexend"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to Chemist?",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "lexend",
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Home();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(0, 128, 128, 1.0),
                          fontFamily: "lexend",
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}