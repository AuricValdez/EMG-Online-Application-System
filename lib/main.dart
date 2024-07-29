import 'package:flutter/material.dart';
import 'login_register_select_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Josefin-Sans',
      ),
      home: const LoginRegisterSelect(title: '',), // Initialize with an empty list
    );
  }
}