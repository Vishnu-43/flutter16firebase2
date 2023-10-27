import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeState extends StatefulWidget {
  const HomeState({super.key});

  @override
  State<HomeState> createState() => _HomeStateState();
}

class _HomeStateState extends State<HomeState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: () async {
          await FirebaseAuth.instance.signOut();
        }, icon: Icon(Icons.leave_bags_at_home))
      ],title: Text('Home'),
      ),
    );
  }
}
