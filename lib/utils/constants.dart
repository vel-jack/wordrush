import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wordrush/controller/user_controller.dart';

Color kLightBgColor = Colors.grey.shade200;
Color kDarkShadowColor = Colors.grey.shade600;

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
UserController userController = UserController.instance;
