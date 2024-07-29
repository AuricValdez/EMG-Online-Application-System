import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMG',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const LoginRegisterSelect(title: 'EMG'),
    );
  }
}

class LoginRegisterSelect extends StatefulWidget {
  final String title;

  const LoginRegisterSelect({Key? key, required this.title}) : super(key: key);

  @override
  _LoginRegisterSelectState createState() => _LoginRegisterSelectState();
}

class _LoginRegisterSelectState extends State<LoginRegisterSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(226, 124, 51, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
            ),
            const Text(
              'EMG',
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Josefin Sans',
              ),
            ),
            const SizedBox(height: 0),
            const Text(
              'ANIMAL CLINIC & \nVETERINARY SUPPLY',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.white70,
                fontFamily: 'Josefin Sans',
              ),
            ),
            const SizedBox(height: 40.0),
            SizedBox(
              width: 220, // Set the desired width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF973D10),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                child: const Text('LOGIN'),
              ),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: 220, // Set the desired width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFED6F00),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'Josefin Sans',
                  ),
                ),
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: Color(0xFFED6F00),
                    fontFamily: 'Josefin Sans',
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
