import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package
import 'package:url_launcher/url_launcher.dart'; // For launching URLs
import 'contact_screen.dart'; // Import your new phone screen

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ensure entire scaffold background is white
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove shadow for a flatter look
      ),
      body: Column(
        children: [
          // Picture section
          Container(
            margin: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0), // Rounded corners
              child: Image.asset(
                'assets/clinic.jpg', // Add your image asset here
                width: double.infinity,
                height: 200, // Fixed height
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Descriptive text section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Center text
                  children: [
                    Text(
                      'Welcome to EMG Animal Clinic & Veterinary Supply',
                      textAlign: TextAlign.center, // Center text
                      style: GoogleFonts.josefinSans(
                        fontSize: 26.0, // Increased font size
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12.0), // Increased spacing
                    Text(
                      'At EMG Animal Clinic, we are dedicated to providing the highest quality care for your beloved pets. Our state-of-the-art facility and experienced staff ensure that your pets receive the best possible treatment. From routine check-ups to emergency care, we are here to meet all your veterinary needs.',
                      textAlign: TextAlign.center, // Center text
                      style: GoogleFonts.josefinSans(
                        fontSize: 18.0, // Slightly increased font size
                        color: Colors.black54, // Softer text color
                      ),
                    ),
                    // Add more text as needed
                  ],
                ),
              ),
            ),
          ),
          // Icons section
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIconButton(
                  icon: Icons.phone,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PhonePage()),
                    );
                  },
                ),
                const SizedBox(width: 20.0),
                _buildIconButton(
                  icon: Icons.facebook,
                  url: 'https://www.facebook.com/emgveterinarysupply',
                ),
                const SizedBox(width: 20.0),
                _buildIconButton(
                  icon: Icons.map,
                  url: 'https://maps.app.goo.gl/Lhs75kKrgVn7wCZ37', // Your Google Maps URL
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, String? url, VoidCallback? onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Ensure the icon background is white
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: 32.0, // Increased icon size
        color: Color.fromRGBO(226, 124, 51, 1), // Orange color
        onPressed: () {
          if (url != null) {
            _launchURL(url);
          } else if (onPressed != null) {
            onPressed();
          }
        },
        splashColor: Colors.transparent, // Remove splash color
        highlightColor: Colors.transparent, // Remove highlight color
        padding: EdgeInsets.zero, // Remove padding
        constraints: BoxConstraints(), // Remove constraints
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
