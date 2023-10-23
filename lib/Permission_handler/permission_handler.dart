import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PermissionHandler extends StatefulWidget {
  const PermissionHandler({super.key});

  @override
  State<PermissionHandler> createState() => _PermissionHandlerState();
}

class _PermissionHandlerState extends State<PermissionHandler> {
  bool? permissionGranted;
  String? imageUrl;
  //final  _FirebaseStorage;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
