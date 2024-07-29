import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pet_selection_screen.dart';
import 'custom_transition.dart';
import 'home_screen.dart';

void navigateToNextScreen(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    CustomPageRoute(
      builder: (context) => PetSelectionScreen(
      ),
    ),
    (Route<dynamic> route) => false, // This removes all previous routes
  );
}

class FinishScreen extends StatefulWidget {
  @override
  _FinishScreenState createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
    void _navigateToHomePage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(226, 124, 51, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'THANK YOU FOR\nUSING',
              textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'EMG',
              textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                fontSize: 60, // Larger font size for EMG
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'ANIMAL CLINIC &',
              style: GoogleFonts.josefinSans(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Text(
              'VETERINARY SUPPLY',
              style: GoogleFonts.josefinSans(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'We will get back to you soon!',
              style: GoogleFonts.josefinSans(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Please check your email for updates!',
              style: GoogleFonts.josefinSans(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 50), // Increased space before the button
            ElevatedButton(
              onPressed: () {
                navigateToNextScreen(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF983C2C),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: GoogleFonts.josefinSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shadowColor: Colors.black, // Add shadow color
                elevation: 8, // Set elevation (brightness of shadow)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
              child: Text(
                'CREATE ANOTHER\nAPPOINTMENT',
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _navigateToHomePage(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: GoogleFonts.josefinSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shadowColor: Colors.black, // Add shadow color
                elevation: 8, // Set elevation (brightness of shadow)
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
              ),
              child: Text(
                'HOME',
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(color: Colors.black),
              ),
            ),
            SizedBox(height: 30),
            Image.asset(
              'assets/logo.png', // Replace with actual image path
              height: 300,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
