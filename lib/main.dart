import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_book/app.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const PhonebookApp());
}