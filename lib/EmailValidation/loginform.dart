import 'dart:math';

import 'package:flutter/material.dart';

import 'authfunction.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey= GlobalKey<FormState>();
  String email= '';
  String password='';
  String fullname='';
  bool login=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Login"),
      ),
      body: Form(
         key: _formKey,
          child: Container(
            padding: EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                login ? Container() :TextFormField(
                  key: ValueKey('fullname'),
                  decoration: InputDecoration(hintText: 'Enter full name'),
                  validator: (value){
                    if(value ! .isEmpty){
                      return 'Please enter Full name';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      fullname= value!;
                    });
                  },
                ),
                TextFormField(
                  key: ValueKey("email"),
                  decoration: InputDecoration(
                    hintText: 'Please enter email',
                  ),
                  validator: (value){ 
                    if(value !.isEmpty || value.contains('@') ){
                      return "Please enter valid email";
                    }
                    else{
                      return null;
                    }
                      
                  },
                  onSaved: (value){
                    setState(() {
                      email = value!;
                    });
                  },
                ),
                TextFormField(
                  key: ValueKey("Password"),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter password'
                  ),
                  validator: (value){
                    if(value !.length<6){
                      return 'Password must be greater than 6';

                    }
                    else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    setState(() {
                      password= value!;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(onPressed:() async {
                    if(_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      login ? AuthServices.signinUser(email, password, context)
                          : AuthServices.signupUser(email, password,fullname,  context);
                    }

                  } , child: Text(login ? 'Login' : 'Signup')),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(onPressed: () {
                  setState(() {
                    login= !login;
                  });
                }, child: Text(login ? "Don't have an account? Signup"
                :"Already have an account? Login"))

              ],
            ),
          )),
    );
  }
}
