
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';


class Otp_Screen extends StatefulWidget {
  const Otp_Screen({Key? key}) : super(key: key);
  @override
  State<Otp_Screen> createState() => _Otp_ScreenState();
}

class _Otp_ScreenState extends State<Otp_Screen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                ),
                Text(
                  "we have sent you \nan OTP,",
                  style: TextStyle(
                    fontFamily: "Sans",
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 6,
                  showCursor: true,
                  onCompleted: (pin) {
                    code = pin;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0, 128, 128, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
// After the user successfully logs in with OTP, get their phone number from the Firebase Authentication object
                        final User? user = FirebaseAuth.instance.currentUser;

// Store the user's phone number in Firestore
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.uid)
                            .set({'phone_number': user.phoneNumber});

                        // AuthCredential credential =
                        // PhoneAuthProvider.credential(
                        //     verificationId: Phone_Login_page.verify,
                        //     smsCode: code);

                        // // Sign the user in (or link) with the credential
                        // await auth.signInWithCredential(credential);

                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (BuildContext context) => Navigation_Bar(),
                        //   ),
                        //   ModalRoute.withName('/'),
                        // );
                      } catch (e) {
                        print("WRONG OTP");
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          elevation: 0,
                          duration: Duration(seconds: 5),
                          content: const Text(
                            "The OTP You've entered is incorrect.Please try again",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "sans"),
                          ),
                          backgroundColor: Colors.teal,
                          action: SnackBarAction(
                            label: 'Dismiss',
                            textColor: Colors.black,
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text(
                      "Verify Phone Number",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "sans",
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   // MaterialPageRoute(
                      //   //   builder: (BuildContext context) => Phone_Login_page(),
                      //   // ),
                      //   ModalRoute.withName('/'),
                      // );
                    },
                    child: Text(
                      "Edit Phone Number?",
                      style: TextStyle(color: Colors.black, fontFamily: "sans"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}